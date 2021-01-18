#import "GlodBuleHTNewsHomeViewController.h"
#import "GlodBuleHTNewsDetailViewController.h"
#import "GlodBuleHTNewsHomeRequest.h"
#import "GlodBuleHTNewsBannerRequest.h"
#import "GlodBuleHTNewsHomeCell.h"
#import "GlodBuleHTNewsHomeBannerCell.h"
#import "GlodBuleHTAdViewCell.h"
@interface GlodBuleHTNewsHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) GlodBuleHTNewsHomeRequest *request;
@property (nonatomic, strong) GlodBuleBJError *error;
@property (nonatomic, assign) BOOL newsRequestDone;
@property (nonatomic, assign) BOOL bannerRequestDone;
@end
@implementation GlodBuleHTNewsHomeViewController
+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedNewsHome");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.bannerRequestDone || !self.newsRequestDone) {
        return 0;
    }
    if (section == 0) {
        return 1;
    }
    return self.newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath.section:%ld  indexPath.row:%ld", indexPath.section, indexPath.row);
    
    if (indexPath.section == 0) {
        kWeakSelf
        GlodBuleHTNewsHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTNewsHomeBannerCell"];
        [cell waterSkysetupWithNewsModels:self.bannerList];
        cell.onBannerTappedBlock = ^(GlodBuleHTNewsModel *newsModel) {
            GlodBuleHTNewsDetailViewController *detailVc = [GlodBuleHTNewsDetailViewController waterSkyviewController];
            detailVc.post_id = newsModel.news_id;
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        };
        return cell;
    }
    
    GlodBuleHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        GlodBuleHTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTAdViewCell"];
        [cell requestAd:self];
        return cell;
    }
    
//    else if (indexPath.section == 2){
//        GlodBuleHTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTAdViewCell"];
//        [cell requestAd:self];
//        return cell;
//    }
    GlodBuleHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GlodBuleHTNewsHomeCell"];
    [cell waterSkysetupWithNewsModel:self.newsList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREEN_WIDTH * 2 / 3;
    }
    
    GlodBuleHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    GlodBuleHTNewsModel *newsModel = self.newsList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    GlodBuleHTNewsDetailViewController *detailVc = [GlodBuleHTNewsDetailViewController waterSkyviewController];
    detailVc.post_id = newsModel.news_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}
#pragma mark - private
- (void)setupViews {
    self.title = @"新聞";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"GlodBuleHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"GlodBuleHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GlodBuleHTNewsHomeBannerCell" bundle:nil]
         forCellReuseIdentifier:@"GlodBuleHTNewsHomeBannerCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GlodBuleHTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"GlodBuleHTAdViewCell"];
    
    kWeakSelf
    self.tableView.mj_header = [GlodBuleMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [GlodBuleMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        weakSelf.tableView.mj_header.hidden = YES;
        [weakSelf loadNextPage];
    }];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.error = nil;
    [self.view showLoadingView];
}
- (void)refreshUI {
    if (!self.bannerRequestDone || !self.newsRequestDone) {
        return;
    }
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    [self.tableView.mj_header endRefreshing];
    if (self.request.hasMore) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.error) {
        if (!self.bannerList || !self.newsList) {
            kWeakSelf
            [self.view showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                [weakSelf.view hideEmptyView];
                [weakSelf.view showLoadingView];
                [weakSelf loadData];
            }];
        } else {
            [self.view showToast:self.error.msg];
        }
        self.error = nil;
    }
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
    [self.tableView reloadData];
}

-(NSArray *) dataWithAd:(NSArray<GlodBuleHTNewsModel *> *)newsList{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < newsList.count; i++ ) {
        if (i==2) {
            GlodBuleHTNewsModel *adModel = [[GlodBuleHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }else if ((i - 2) % 6 == 0){
            GlodBuleHTNewsModel *adModel = [[GlodBuleHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }
        
        [tmpArray addObject:newsList[i]];
    }
    
    return tmpArray;
    
}

- (void)loadData {
    self.bannerRequestDone = NO;
    self.newsRequestDone = NO;
    kWeakSelf
    [self.request waterSkyrequestWithSuccessBlock:^(NSArray<GlodBuleHTNewsModel *> *newsList) {
//        weakSelf.newsList = newsList;
        weakSelf.newsList = [weakSelf dataWithAd:newsList];
        weakSelf.newsRequestDone = YES;
        for (GlodBuleHTNewsModel *nXRRFATKHTNewsModel in newsList) {
            NSLog(@"new imgurl: %@ newsId: %@",nXRRFATKHTNewsModel.img_url,nXRRFATKHTNewsModel.news_id);
        }
        [weakSelf refreshUI];
    } errorBlock:^(GlodBuleBJError *error) {
        weakSelf.error = error;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    }];
    [GlodBuleHTNewsBannerRequest waterSkyrequestWithSuccessBlock:^(NSArray<GlodBuleHTNewsModel *> *bannerList) {
        weakSelf.bannerList = bannerList;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(GlodBuleBJError *error) {
        weakSelf.error = error;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    self.newsRequestDone = NO;
    kWeakSelf
    [self.request waterSkyloadNextPageWithSuccessBlock:^(NSArray<GlodBuleHTNewsModel *> *newsList) {
//        weakSelf.newsList = newsList;
         weakSelf.newsList = [weakSelf dataWithAd:newsList];
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
     } errorBlock:^(GlodBuleBJError *error) {
         weakSelf.newsRequestDone = YES;
         [weakSelf refreshUI];
     }];
}
#pragma mark - lazy load
- (GlodBuleHTNewsHomeRequest *)request {
    if (!_request) {
        _request = [[GlodBuleHTNewsHomeRequest alloc] init];
    }
    return _request;
}
@end
