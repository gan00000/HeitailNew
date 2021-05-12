#import "NDeskHTNewsHomeViewController.h"
#import "HourseHTNewsDetailViewController.h"
#import "KMonkeyHTNewsHomeRequest.h"
#import "GGCatHTNewsBannerRequest.h"
#import "YYPackageHTNewsHomeCell.h"
#import "KMonkeyHTNewsHomeBannerCell.h"
#import "MMTodayHTAdViewCell.h"
@interface NDeskHTNewsHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) KMonkeyHTNewsHomeRequest *request;
@property (nonatomic, strong) SundayBJError *error;
@property (nonatomic, assign) BOOL newsRequestDone;
@property (nonatomic, assign) BOOL bannerRequestDone;
@end
@implementation NDeskHTNewsHomeViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"UKRosRedNewsHome");
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

        YYPackageHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYPackageHTNewsHomeCell"];
        [cell taosetupWithNewsModel:self.bannerList[indexPath.row]];
        cell.topLabel.hidden = NO;
        return cell;
    }
    
    PXFunHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        MMTodayHTAdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTodayHTAdViewCell"];
        [cell requestAd:self];
        return cell;
    }
    
    YYPackageHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYPackageHTNewsHomeCell"];
    [cell taosetupWithNewsModel:self.newsList[indexPath.row]];
    cell.topLabel.hidden = YES;
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //return SCREEN_WIDTH * 2 / 3;
        return YYPackageHTNewsHomeCell.xHTNewsHomeCellHeight;
    }
    
    PXFunHTNewsModel *mmModel = self.newsList[indexPath.row];
    if ([mmModel.news_id isEqualToString:@"-100"]) {
        return 250;
    }
    return YYPackageHTNewsHomeCell.xHTNewsHomeCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PXFunHTNewsModel *newsModel = self.bannerList[indexPath.row];
        HourseHTNewsDetailViewController *detailVc = [HourseHTNewsDetailViewController taoviewController];
        detailVc.post_id = newsModel.news_id;
        [self.navigationController pushViewController:detailVc animated:YES];
        return;
    }
    PXFunHTNewsModel *newsModel = self.newsList[indexPath.row];
    if ([newsModel.news_id isEqualToString:@"-100"]) {
        return;
    }
    HourseHTNewsDetailViewController *detailVc = [HourseHTNewsDetailViewController taoviewController];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"YYPackageHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"YYPackageHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"KMonkeyHTNewsHomeBannerCell" bundle:nil]
         forCellReuseIdentifier:@"KMonkeyHTNewsHomeBannerCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTodayHTAdViewCell" bundle:nil]
    forCellReuseIdentifier:@"MMTodayHTAdViewCell"];
    
    kWeakSelf
    self.tableView.mj_header = [HourseMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [HourseMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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

-(NSArray *) dataWithAd:(NSArray<PXFunHTNewsModel *> *)newsList{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < newsList.count; i++ ) {
        if (i==2) {
            PXFunHTNewsModel *adModel = [[PXFunHTNewsModel alloc] init];
            adModel.news_id = @"-100";
            [tmpArray addObject:adModel];
        }else if ((i - 2) % 6 == 0){
            PXFunHTNewsModel *adModel = [[PXFunHTNewsModel alloc] init];
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
    [self.request taorequestWithSuccessBlock:^(NSArray<PXFunHTNewsModel *> *newsList) {
//        weakSelf.newsList = newsList;
        weakSelf.newsList = [weakSelf dataWithAd:newsList];
        weakSelf.newsRequestDone = YES;
//        for (PXFunHTNewsModel *nXRRFATKHTNewsModel in newsList) {
//            NSLog(@"new imgurl: %@ newsId: %@",nXRRFATKHTNewsModel.img_url,nXRRFATKHTNewsModel.news_id);
//        }
        [weakSelf refreshUI];
    } errorBlock:^(SundayBJError *error) {
        weakSelf.error = error;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    }];
    [GGCatHTNewsBannerRequest taorequestWithSuccessBlock:^(NSArray<PXFunHTNewsModel *> *bannerList) {
        weakSelf.bannerList = bannerList;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(SundayBJError *error) {
        weakSelf.error = error;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    self.newsRequestDone = NO;
    kWeakSelf
    [self.request taoloadNextPageWithSuccessBlock:^(NSArray<PXFunHTNewsModel *> *newsList) {
//        weakSelf.newsList = newsList;
         weakSelf.newsList = [weakSelf dataWithAd:newsList];
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
     } errorBlock:^(SundayBJError *error) {
         weakSelf.newsRequestDone = YES;
         [weakSelf refreshUI];
     }];
}
#pragma mark - lazy load
- (KMonkeyHTNewsHomeRequest *)request {
    if (!_request) {
        _request = [[KMonkeyHTNewsHomeRequest alloc] init];
    }
    return _request;
}
@end
