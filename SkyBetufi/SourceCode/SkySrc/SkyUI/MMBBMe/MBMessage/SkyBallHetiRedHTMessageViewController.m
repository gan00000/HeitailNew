#import "SkyBallHetiRedHTMessageViewController.h"
#import "SkyBallHetiRedHTUserRequest.h"
#import "SkyBallHetiRedHTMyMessaageCell.h"
#import "SkyBallHetiRedHTNewsDetailViewController.h"
@interface SkyBallHetiRedHTMessageViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<SkyBallHetiRedHTMyMessageModel *> *dataSource;
@property (nonatomic, assign) NSInteger offset;
@end
@implementation SkyBallHetiRedHTMessageViewController
+ (instancetype)waterSkyviewController {
    return [[SkyBallHetiRedHTMessageViewController alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    self.dataSource = [NSMutableArray array];
    [self.view showLoadingView];
    [self loadData];
    [self setupTableView];
}
- (void)loadData {
    [SkyBallHetiRedHTUserRequest waterSkyrequestMyMessageWithOffset:self.offset successBlock:^(NSArray<SkyBallHetiRedHTMyMessageModel *> * _Nonnull messageList, NSInteger pages) {
        for (SkyBallHetiRedHTMyMessageModel *model in messageList) {
            [model waterSky_countHeight];
        }
        [self.dataSource addObjectsFromArray:messageList];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        if (pages > self.offset+1) {
            self.offset ++;
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (messageList.count == 0) {
            [self.view showEmptyView];
        }
        [self.view hideLoadingView];
    } failBlock:^(SkyBallHetiRedBJError *error) {
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
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTMyMessaageCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTMyMessaageCell"];
    kWeakSelf
    self.tableView.mj_header = [SkyBallHetiRedMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf reloadData];
    }];
    self.tableView.mj_footer = [SkyBallHetiRedMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        weakSelf.tableView.mj_header.hidden = YES;
        [weakSelf loadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SkyBallHetiRedHTMyMessageModel *mesageModel = self.dataSource[indexPath.row];
    return mesageModel.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SkyBallHetiRedHTMyMessaageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTMyMessaageCell"];
    [cell waterSkyrefreshWithMyMessageModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SkyBallHetiRedHTMyMessageModel *mesageModel = self.dataSource[indexPath.row];
    SkyBallHetiRedHTNewsDetailViewController *detailVc = [SkyBallHetiRedHTNewsDetailViewController waterSkyviewController];
    detailVc.post_id = mesageModel.post_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
