#import "KSasxHTNewsHomeViewController.h"
#import "KSasxHTNewsDetailViewController.h"
#import "YeYeeHTNewsHomeRequest.h"
#import "KSasxHTNewsBannerRequest.h"
#import "KSasxHTNewsHomeCell.h"
#import "BByasHTNewsHomeBannerCell.h"
#import "WSKggHTAdViewCell.h"
@interface KSasxHTNewsHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) YeYeeHTNewsHomeRequest *request;
@property (nonatomic, strong) WSKggBJError *error;
@property (nonatomic, assign) BOOL newsRequestDone;
@property (nonatomic, assign) BOOL bannerRequestDone;
@end
@implementation KSasxHTNewsHomeViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"FaCaiNewsHome");
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
        return self.bannerList.count;
    }
    return self.newsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath.section:%ld  indexPath.row:%ld", indexPath.section, indexPath.row);
    
    if (indexPath.section == 0) {//有热门

        KSasxHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsHomeCell"];
        [cell taosetupWithNewsModel:self.bannerList[indexPath.row]];
        cell.topLabel.hidden = NO;
        return cell;
    }
    
    CfipyHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        WSKggHTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSKggHTAdViewCell"];
        [cell requestAd:self];
        return cell;
    }
    
    KSasxHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KSasxHTNewsHomeCell"];
    [cell taosetupWithNewsModel:self.newsList[indexPath.row]];
    cell.topLabel.hidden = YES;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //return SCREEN_WIDTH * 2 / 3;
        return KSasxHTNewsHomeCell.xHTNewsHomeCellHeight;
    }
    
    CfipyHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return KSasxHTNewsHomeCell.xHTNewsHomeCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CfipyHTNewsModel *newsModel = self.bannerList[indexPath.row];
        KSasxHTNewsDetailViewController *detailVc = [KSasxHTNewsDetailViewController taoviewController];
        detailVc.post_id = newsModel.news_id;
        [self.navigationController pushViewController:detailVc animated:YES];
        return;
    }
    CfipyHTNewsModel *newsModel = self.newsList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    KSasxHTNewsDetailViewController *detailVc = [KSasxHTNewsDetailViewController taoviewController];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"KSasxHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"KSasxHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BByasHTNewsHomeBannerCell" bundle:nil]
         forCellReuseIdentifier:@"BByasHTNewsHomeBannerCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WSKggHTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"WSKggHTAdViewCell"];
    
    kWeakSelf
    self.tableView.mj_header = [YeYeeMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [YeYeeMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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

-(NSArray *) dataWithAd:(NSArray<CfipyHTNewsModel *> *)newsList{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < newsList.count; i++ ) {
        if (i==2) {
            CfipyHTNewsModel *adModel = [[CfipyHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }else if ((i - 2) % 6 == 0){
            CfipyHTNewsModel *adModel = [[CfipyHTNewsModel alloc] init];
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
    [self.request taorequestWithSuccessBlock:^(NSArray<CfipyHTNewsModel *> *newsList) {
//        weakSelf.newsList = newsList;
        weakSelf.newsList = [weakSelf dataWithAd:newsList];
        weakSelf.newsRequestDone = YES;
//        for (CfipyHTNewsModel *nXRRFATKHTNewsModel in newsList) {
//            NSLog(@"new imgurl: %@ newsId: %@",nXRRFATKHTNewsModel.img_url,nXRRFATKHTNewsModel.news_id);
//        }
        [weakSelf refreshUI];
    } errorBlock:^(WSKggBJError *error) {
        weakSelf.error = error;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    }];
    [KSasxHTNewsBannerRequest taorequestWithSuccessBlock:^(NSArray<CfipyHTNewsModel *> *bannerList) {
        weakSelf.bannerList = bannerList;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(WSKggBJError *error) {
        weakSelf.error = error;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    self.newsRequestDone = NO;
    kWeakSelf
    [self.request taoloadNextPageWithSuccessBlock:^(NSArray<CfipyHTNewsModel *> *newsList) {
//        weakSelf.newsList = newsList;
         weakSelf.newsList = [weakSelf dataWithAd:newsList];
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
     } errorBlock:^(WSKggBJError *error) {
         weakSelf.newsRequestDone = YES;
         [weakSelf refreshUI];
     }];
}
#pragma mark - lazy load
- (YeYeeHTNewsHomeRequest *)request {
    if (!_request) {
        _request = [[YeYeeHTNewsHomeRequest alloc] init];
    }
    return _request;
}
@end
