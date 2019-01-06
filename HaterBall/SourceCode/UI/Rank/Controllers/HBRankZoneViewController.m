#import "HBRankZoneViewController.h"
#import "HBRankZoneRequest.h"
#import "HBRankHomeCell.h"
@interface HBRankZoneViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HBRankZoneModel *zoneModel;
@property (nonatomic, strong) HBBJError *error;
@end
@implementation HBRankZoneViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"RankZone");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self loadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.zoneModel) {
        return 0;
    }
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBRankHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBRankHomeCell class])];
    switch (indexPath.row) {
        case 0:
            [cell setupWithTitle:@"大西洋賽區 - 東部" rankList:self.zoneModel.EasternAtlantic];
            break;
        case 1:
            [cell setupWithTitle:@"中部賽區 - 東部" rankList:self.zoneModel.EasternCentral];
            break;
        case 2:
            [cell setupWithTitle:@"東南賽區 - 東部" rankList:self.zoneModel.EasternSoutheast];
            break;
        case 3:
            [cell setupWithTitle:@"西南賽區 - 西部" rankList:self.zoneModel.WesternSouthwest];
            break;
        case 4:
            [cell setupWithTitle:@"太平洋賽區 - 西部" rankList:self.zoneModel.WesternPacific];
            break;
        case 5:
            [cell setupWithTitle:@"西北賽區 - 西部" rankList:self.zoneModel.WesternNorthwest];
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
            return (self.zoneModel.EasternAtlantic.count + 1) * 30 + 45;
        case 1:
            return (self.zoneModel.EasternCentral.count + 1) * 30 + 45;
        case 2:
            return (self.zoneModel.EasternSoutheast.count + 1) * 30 + 45;
        case 3:
            return (self.zoneModel.WesternSouthwest.count + 1) * 30 + 45;
        case 4:
            return (self.zoneModel.WesternPacific.count + 1) * 30 + 45;
            break;
        case 5:
            return (self.zoneModel.WesternNorthwest.count + 1) * 30 + 45;
        default:
            return 0;
    }
}
#pragma mark - private
- (void)loadData {
    [HBRankZoneRequest requestWithSuccessBlock:^(HBRankZoneModel *zoneModel) {
        self.zoneModel = zoneModel;
        [self refreshUI];
    } errorBlock:^(HBBJError *error) {
        self.error = error;
        [self refreshUI];
    }];
}
- (void)refreshUI {
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    [self.tableView.mj_header endRefreshing];
    if (self.error) {
        if (!self.zoneModel) {
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBRankHomeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBRankHomeCell class])];
    kWeakSelf
    self.tableView.mj_header = [HBMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    [self.view showLoadingView];
}
@end
