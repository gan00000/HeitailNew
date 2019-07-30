#import "XRRFATKHTHistoryViewController.h"
#import "XRRFATKHTUserRequest.h"
#import "XRRFATKHTNewsHomeCell.h"
#import "XRRFATKHTNewsDetailViewController.h"
@interface XRRFATKHTHistoryViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<XRRFATKHTNewsModel *> *dataSource;
@property (nonatomic, assign) NSInteger offset;
@end
@implementation XRRFATKHTHistoryViewController
+ (instancetype)skargviewController {
    return [[XRRFATKHTHistoryViewController alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"瀏覽歷史";
    self.dataSource = [NSMutableArray array];
    [self.view showLoadingView];
    [self loadData];
    [self setupTableView];
}
- (void)loadData {
    [XRRFATKHTUserRequest skargrequestHistoryWithOffset:self.offset successBlock:^(NSArray<XRRFATKHTNewsModel *> * _Nonnull newsList, NSInteger pages) {
        [self.dataSource addObjectsFromArray:newsList];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        if (pages > self.offset+1) {
            self.offset ++;
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (newsList.count == 0) {
            [self.view showEmptyView];
        }
        [self.view hideLoadingView];
    } failBlock:^(XRRFATKBJError *error) {
        [self.view hideLoadingView];
        [self.view showEmptyViewWithTitle:@"獲取數據失敗，點擊重試" tapBlock:^{
            [self.view hideEmptyView];
            [self.view showLoadingView];
            [self loadData];
        }];
    }];
}
- (void)reloadData {
    self.offset = 0;
    [self.dataSource removeAllObjects];
    [self loadData];
}
- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.rowHeight = 90;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"XRRFATKHTNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"XRRFATKHTNewsHomeCell"];
    kWeakSelf
    self.tableView.mj_header = [XRRFATKMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf reloadData];
    }];
    self.tableView.mj_footer = [XRRFATKMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        weakSelf.tableView.mj_header.hidden = YES;
        [weakSelf loadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XRRFATKHTNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XRRFATKHTNewsHomeCell"];
    [cell skargsetupWithNewsModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XRRFATKHTNewsModel *newsModel = self.dataSource[indexPath.row];
    XRRFATKHTNewsDetailViewController *detailVc = [XRRFATKHTNewsDetailViewController skargviewController];
    detailVc.post_id = newsModel.news_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
