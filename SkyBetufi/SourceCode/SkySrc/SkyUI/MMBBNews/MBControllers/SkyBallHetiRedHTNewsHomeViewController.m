#import "SkyBallHetiRedHTNewsHomeViewController.h"
#import "SkyBallHetiRedHTNewsDetailViewController.h"
#import "SkyBallHetiRedHTNewsHomeRequest.h"
#import "SkyBallHetiRedHTNewsBannerRequest.h"
#import "SkyBallHetiRedHTNewsHomeCell.h"
#import "SkyBallHetiRedHTNewsHomeBannerCell.h"
@interface SkyBallHetiRedHTNewsHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) SkyBallHetiRedHTNewsHomeRequest *request;
@property (nonatomic, strong) SkyBallHetiRedBJError *error;
@property (nonatomic, assign) BOOL newsRequestDone;
@property (nonatomic, assign) BOOL bannerRequestDone;
@end
@implementation SkyBallHetiRedHTNewsHomeViewController
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
    if (indexPath.section == 0) {
        kWeakSelf
        SkyBallHetiRedHTNewsHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTNewsHomeBannerCell"];
        [cell waterSkysetupWithNewsModels:self.bannerList];
        cell.onBannerTappedBlock = ^(SkyBallHetiRedHTNewsModel *newsModel) {
            SkyBallHetiRedHTNewsDetailViewController *detailVc = [SkyBallHetiRedHTNewsDetailViewController waterSkyviewController];
            detailVc.post_id = newsModel.news_id;
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        };
        return cell;
    }
    SkyBallHetiRedHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTNewsHomeCell"];
    [cell waterSkysetupWithNewsModel:self.newsList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREEN_WIDTH * 2 / 3;
    }
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    SkyBallHetiRedHTNewsModel *newsModel = self.newsList[indexPath.row];
    SkyBallHetiRedHTNewsDetailViewController *detailVc = [SkyBallHetiRedHTNewsDetailViewController waterSkyviewController];
    detailVc.post_id = newsModel.news_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}
#pragma mark - private
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTNewsHomeBannerCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTNewsHomeBannerCell"];
    kWeakSelf
    self.tableView.mj_header = [SkyBallHetiRedMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [SkyBallHetiRedMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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
- (void)loadData {
    self.bannerRequestDone = NO;
    self.newsRequestDone = NO;
    kWeakSelf
    [self.request waterSkyrequestWithSuccessBlock:^(NSArray<SkyBallHetiRedHTNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        weakSelf.newsRequestDone = YES;
        for (SkyBallHetiRedHTNewsModel *nXRRFATKHTNewsModel in newsList) {
            NSLog(@"new imgurl: %@ newsId: %@",nXRRFATKHTNewsModel.img_url,nXRRFATKHTNewsModel.news_id);
        }
        [weakSelf refreshUI];
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        weakSelf.error = error;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    }];
    [SkyBallHetiRedHTNewsBannerRequest waterSkyrequestWithSuccessBlock:^(NSArray<SkyBallHetiRedHTNewsModel *> *bannerList) {
        weakSelf.bannerList = bannerList;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        weakSelf.error = error;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    self.newsRequestDone = NO;
    kWeakSelf
    [self.request waterSkyloadNextPageWithSuccessBlock:^(NSArray<SkyBallHetiRedHTNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
     } errorBlock:^(SkyBallHetiRedBJError *error) {
         weakSelf.newsRequestDone = YES;
         [weakSelf refreshUI];
     }];
}
#pragma mark - lazy load
- (SkyBallHetiRedHTNewsHomeRequest *)request {
    if (!_request) {
        _request = [[SkyBallHetiRedHTNewsHomeRequest alloc] init];
    }
    return _request;
}
@end
