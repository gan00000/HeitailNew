#import "HBNewsHomeViewController.h"
#import "HBNewsDetailViewController.h"
#import "HBNewsHomeRequest.h"
#import "HBNewsBannerRequest.h"
#import "HBNewsHomeCell.h"
#import "HBNewsHomeBannerCell.h"
@interface HBNewsHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) HBNewsHomeRequest *request;
@property (nonatomic, strong) HBBJError *error;
@property (nonatomic, assign) BOOL newsRequestDone;
@property (nonatomic, assign) BOOL bannerRequestDone;
@end
@implementation HBNewsHomeViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"NewsHome");
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
        HBNewsHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBNewsHomeBannerCell"];
        [cell setupWithNewsModels:self.bannerList];
        cell.onBannerTappedBlock = ^(HBNewsModel *newsModel) {
            HBNewsDetailViewController *detailVc = [HBNewsDetailViewController viewController];
            detailVc.newsModel = newsModel;
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        };
        return cell;
    }
    HBNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBNewsHomeCell"];
    [cell setupWithNewsModel:self.newsList[indexPath.row]];
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
    HBNewsModel *newsModel = self.newsList[indexPath.row];
    HBNewsDetailViewController *detailVc = [HBNewsDetailViewController viewController];
    detailVc.newsModel = newsModel;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"HBNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HBNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HBNewsHomeBannerCell" bundle:nil]
         forCellReuseIdentifier:@"HBNewsHomeBannerCell"];
    kWeakSelf
    self.tableView.mj_header = [HBMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [HBMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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
    [self.request requestWithSuccessBlock:^(NSArray<HBNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(HBBJError *error) {
        weakSelf.error = error;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
    }];
    [HBNewsBannerRequest requestWithSuccessBlock:^(NSArray<HBNewsModel *> *bannerList) {
        weakSelf.bannerList = bannerList;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(HBBJError *error) {
        weakSelf.error = error;
        weakSelf.bannerRequestDone = YES;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    self.newsRequestDone = NO;
    kWeakSelf
    [self.request loadNextPageWithSuccessBlock:^(NSArray<HBNewsModel *> *newsList) {
        weakSelf.newsList = newsList;
        weakSelf.newsRequestDone = YES;
        [weakSelf refreshUI];
     } errorBlock:^(HBBJError *error) {
         weakSelf.newsRequestDone = YES;
         [weakSelf refreshUI];
     }];
}
#pragma mark - lazy load
- (HBNewsHomeRequest *)request {
    if (!_request) {
        _request = [[HBNewsHomeRequest alloc] init];
    }
    return _request;
}
@end
