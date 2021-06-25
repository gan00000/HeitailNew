#import "KSasxHTRankEastWestViewController.h"
#import "UUaksHTRankEastWestRequest.h"
#import "KSasxHTRankHomeCell.h"
@interface KSasxHTRankEastWestViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) BByasHTRankEastWestModel *eastWestModel;
@property (nonatomic, strong) WSKggBJError *error;
@end
@implementation KSasxHTRankEastWestViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"FaCaiRankEastWest");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self loadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.eastWestModel) {
        return 0;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSasxHTRankHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KSasxHTRankHomeCell class])];
    switch (indexPath.row) {
        case 0:
            [cell taosetupWithTitle:@"東部" rankList:self.eastWestModel.Eastern];
            break;
        case 1:
            [cell taosetupWithTitle:@"西部" rankList:self.eastWestModel.Western];
            break;
        default:
            break;
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return (self.eastWestModel.Eastern.count + 1) * 40 + 45;
        case 1:
            return (self.eastWestModel.Western.count + 1) * 40 + 45;
        default:
            return 0;
    }
}
#pragma mark - private
- (void)loadData {
    [UUaksHTRankEastWestRequest taorequestWithSuccessBlock:^(BByasHTRankEastWestModel *eastWestModel) {
        self.eastWestModel = eastWestModel;
        [self refreshUI];
        if (eastWestModel.Eastern.count == 0) {
            [self.view showEmptyViewWithTitle:@"暫無數據，點擊刷新" tapBlock:^{
                [self.view hideEmptyView];
                [self.view showLoadingView];
                [self loadData];
            }];
        }
    } errorBlock:^(WSKggBJError *error) {
        self.error = error;
        [self refreshUI];
    }];
}
- (void)refreshUI {
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    [self.tableView.mj_header endRefreshing];
    if (self.error) {
        if (!self.eastWestModel) {
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
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KSasxHTRankHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([KSasxHTRankHomeCell class])];
    kWeakSelf
    self.tableView.mj_header = [YeYeeMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.view showLoadingView];
}
@end
