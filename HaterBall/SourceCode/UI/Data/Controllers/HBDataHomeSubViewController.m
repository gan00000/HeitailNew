#import "HBDataHomeSubViewController.h"
#import "HBDataMoreViewController.h"
#import "HBDataHomeRequest.h"
#import "HBDataHomePlayerCell.h"
#import "HBDataHomeTeamCell.h"
#import "HBDataHomeHeaderCell.h"
@interface HBDataHomeSubViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HBDataHomeInfoModel *homeInfoModel;
@property (nonatomic, strong) HBBJError *error;
@end
@implementation HBDataHomeSubViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"DataHomeSub");
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
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.homeInfoModel) {
        return 0;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBDataHomeHeaderCell *headerCell;
    HBDataHomePlayerCell *playerCell;
    HBDataHomeTeamCell *teamCell;
    if (indexPath.row == 0) {
        headerCell = [tableView dequeueReusableCellWithIdentifier:@"HBDataHomeHeaderCell"];
    } else {
        if (self.type == 1) {
            playerCell = [tableView dequeueReusableCellWithIdentifier:@"HBDataHomePlayerCell"];
        } else {
            teamCell = [tableView dequeueReusableCellWithIdentifier:@"HBDataHomeTeamCell"];
        }
    }
    switch (indexPath.section) {
        case 0: {
            headerCell.title = @"得分";
            [playerCell setupWithDatas:self.homeInfoModel.pts];
            [teamCell setupWithDatas:self.homeInfoModel.pts];
        } break;
        case 1: {
            headerCell.title = @"籃板";
            [playerCell setupWithDatas:self.homeInfoModel.reb];
            [teamCell setupWithDatas:self.homeInfoModel.reb];
        } break;
        case 2: {
            headerCell.title = @"助攻";
            [playerCell setupWithDatas:self.homeInfoModel.ast];
            [teamCell setupWithDatas:self.homeInfoModel.ast];
        } break;
        case 3: {
            headerCell.title = @"搶斷";
            [playerCell setupWithDatas:self.homeInfoModel.stl];
            [teamCell setupWithDatas:self.homeInfoModel.stl];
        } break;
        case 4: {
            headerCell.title = @"蓋帽";
            [playerCell setupWithDatas:self.homeInfoModel.blk];
            [teamCell setupWithDatas:self.homeInfoModel.blk];
        } break;
        case 5: {
            headerCell.title = @"失誤";
            [playerCell setupWithDatas:self.homeInfoModel.turnover];
            [teamCell setupWithDatas:self.homeInfoModel.turnover];
        } break;
        default:
            break;
    }
    if (headerCell) {
        return headerCell;
    } else if (playerCell) {
        return playerCell;
    } else {
        return teamCell;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40;
    }
    if (self.type == 1) { 
        return (SCREEN_WIDTH/5-30) * 3 / 2 + 105;
    } else {
        return SCREEN_WIDTH/5 + 48;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        return;
    }
    NSMutableString *title = [NSMutableString stringWithString:self.type==1?@"球員":@"球隊"];
    HBDataMoreViewController *moreVc = [HBDataMoreViewController viewController];
    moreVc.type = self.type;
    switch (indexPath.section) {
        case 0: {
            moreVc.subType = @"pts";
            [title appendString:@"得分"];
        } break;
        case 1: {
            moreVc.subType = @"reb";
            [title appendString:@"籃板"];
        } break;
        case 2: {
            moreVc.subType = @"ast";
            [title appendString:@"助攻"];
        } break;
        case 3: {
            moreVc.subType = @"stl";
            [title appendString:@"搶斷"];
        } break;
        case 4: {
            moreVc.subType = @"blk";
            [title appendString:@"蓋帽"];
        } break;
        case 5: {
            moreVc.subType = @"turnover";
            [title appendString:@"失誤"];
        } break;
        default:
            break;
    }
    [title appendString:@"排行"];
    moreVc.title = title;
    [self.navigationController pushViewController:moreVc animated:YES];
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
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (self.type == 1) {
        [self.tableView registerNib:[UINib nibWithNibName:@"HBDataHomePlayerCell" bundle:nil]
             forCellReuseIdentifier:@"HBDataHomePlayerCell"];
    } else {
        [self.tableView registerNib:[UINib nibWithNibName:@"HBDataHomeTeamCell" bundle:nil]
             forCellReuseIdentifier:@"HBDataHomeTeamCell"];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"HBDataHomeHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"HBDataHomeHeaderCell"];
    kWeakSelf
    self.tableView.mj_header = [HBMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.error = nil;
    [self.view showLoadingView];
}
- (void)refreshUI {
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    [self.tableView.mj_header endRefreshing];
    if (self.error) {
        if (!self.homeInfoModel) {
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
    [HBDataHomeRequest requestWithType:self.type successBlock:^(HBDataHomeInfoModel *infoModel) {
        self.homeInfoModel = infoModel;
        [self refreshUI];
    } errorBlock:^(HBBJError *error) {
        self.error = error;
        [self refreshUI];
    }];
}
@end
