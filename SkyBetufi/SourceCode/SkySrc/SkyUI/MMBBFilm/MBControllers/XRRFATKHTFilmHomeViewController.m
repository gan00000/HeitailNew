#import "XRRFATKHTFilmHomeViewController.h"
#import "XRRFATKHTNewsDetailViewController.h"
#import "XRRFATKHTFilmHomeRequest.h"
#import "XRRFATKHTFilmHomeCell.h"
#import "XRRFATKHTNewsHomeCell.h"
@interface XRRFATKHTFilmHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) XRRFATKHTFilmHomeRequest *request;
@property (nonatomic, strong) NSArray *filmList;
@property (nonatomic, strong) XRRFATKBJError *error;
@end
@implementation XRRFATKHTFilmHomeViewController
+ (instancetype)skargviewController {
    return kLoadStoryboardWithName(@"XRRFATKFilmHome");
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
    XRRFATKHTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        XRRFATKHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XRRFATKHTNewsHomeCell"];
        [cell skargsetupWithNewsModel:model];
        return cell;
    }
    XRRFATKHTFilmHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XRRFATKHTFilmHomeCell"];
    [cell skargsetupWithNewsModel:self.filmList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XRRFATKHTNewsModel *model = self.filmList[indexPath.row];
    if ([model.news_type isEqualToString:@"新聞"]) {
        return 90;
    }
    return model.filmCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XRRFATKHTNewsModel *newsModel = self.filmList[indexPath.row];
    XRRFATKHTNewsDetailViewController *detailVc = [XRRFATKHTNewsDetailViewController skargviewController];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTFilmHomeCell" bundle:nil]
         forCellReuseIdentifier:@"XRRFATKHTFilmHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"XRRFATKHTNewsHomeCell"];
    kWeakSelf
    self.tableView.mj_header = [XRRFATKMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.tableView.mj_footer = [XRRFATKMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
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
    [self.request skargrequestWithSuccessBlock:^(NSArray<XRRFATKHTNewsModel *> *newsList) {
        weakSelf.filmList = newsList;
        [weakSelf refreshUI];
    } errorBlock:^(XRRFATKBJError *error) {
        weakSelf.error = error;
        [weakSelf refreshUI];
    }];
}
- (void)loadNextPage {
    kWeakSelf
    [self.request loadNextPageWithSuccessBlock:^(NSArray<XRRFATKHTNewsModel *> *newsList) {
        weakSelf.filmList = newsList;
        [weakSelf refreshUI];
    } errorBlock:^(XRRFATKBJError *error) {
        [weakSelf refreshUI];
    }];
}
#pragma mark - lazy load
- (XRRFATKHTFilmHomeRequest *)request {
    if (!_request) {
        _request = [[XRRFATKHTFilmHomeRequest alloc] init];
    }
    return _request;
}
@end
