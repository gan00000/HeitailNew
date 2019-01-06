#import "HBFilmHomeViewController.h"
#import "HBNewsDetailViewController.h"
#import "HBFilmHomeRequest.h"
#import "HBFilmHomeCell.h"
#import "HBNewsHomeCell.h"
@interface HBFilmHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HBFilmHomeRequest *request;
@property (nonatomic, strong) NSArray *filmList;
@property (nonatomic, strong) HBBJError *error;
@end
@implementation HBFilmHomeViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"FilmHome");
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filmList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        HBNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBNewsHomeCell"];
        [cell setupWithNewsModel:model];
        return cell;
    }
    HBFilmHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBFilmHomeCell"];
    [cell setupWithNewsModel:self.filmList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        return 90;
    }
    return model.filmCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HBNewsModel *newsModel = self.filmList[indexPath.row];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"HBFilmHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HBFilmHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HBNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HBNewsHomeCell"];
    kWeakSelf
    self.tableView.mj_header = [HBMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [HBMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    [self.tableView.mj_header endRefreshing];
    if (self.request.hasMore) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.error) {
        if (!self.filmList) {
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
    [self.tableView reloadData];
}
- (void)loadData {
    kWeakSelf
    [self.request requestWithSuccessBlock:^(NSArray<HBNewsModel *> *newsList) {
        weakSelf.filmList = newsList;
        [weakSelf refreshUI];
    } errorBlock:^(HBBJError *error) {
        weakSelf.error = error;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    kWeakSelf
    [self.request loadNextPageWithSuccessBlock:^(NSArray<HBNewsModel *> *newsList) {
        weakSelf.filmList = newsList;
        [weakSelf refreshUI];
    } errorBlock:^(HBBJError *error) {
        [weakSelf refreshUI];
    }];
}
#pragma mark - lazy load
- (HBFilmHomeRequest *)request {
    if (!_request) {
        _request = [[HBFilmHomeRequest alloc] init];
    }
    return _request;
}
@end
