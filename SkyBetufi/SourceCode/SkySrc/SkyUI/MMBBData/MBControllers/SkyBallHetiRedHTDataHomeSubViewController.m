#import "SkyBallHetiRedHTDataHomeSubViewController.h"
#import "SkyBallHetiRedHTDataMoreViewController.h"
#import "SkyBallHetiRedHTDataHomeRequest.h"
#import "SkyBallHetiRedHTDataHomePlayerCell.h"
#import "SkyBallHetiRedHTDataHomeTeamCell.h"
#import "SkyBallHetiRedHTDataHomeHeaderCell.h"
@interface SkyBallHetiRedHTDataHomeSubViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SkyBallHetiRedHTDataHomeInfoModel *homeInfoModel;
@property (nonatomic, strong) SkyBallHetiRedBJError *error;
@end
@implementation SkyBallHetiRedHTDataHomeSubViewController
+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedDataHomeSub");
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
    SkyBallHetiRedHTDataHomeHeaderCell *headerCell;
    SkyBallHetiRedHTDataHomePlayerCell *playerCell;
    SkyBallHetiRedHTDataHomeTeamCell *teamCell;
    if (indexPath.row == 0) {
        headerCell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTDataHomeHeaderCell"];
    } else {
        if (self.type == 1) {
            playerCell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTDataHomePlayerCell"];
        } else {
            teamCell = [tableView dequeueReusableCellWithIdentifier:@"SkyBallHetiRedHTDataHomeTeamCell"];
        }
    }
    switch (indexPath.section) {
        case 0: {
            headerCell.title = @"得分";
            [playerCell waterSkysetupWithDatas:self.homeInfoModel.pts];
            [teamCell waterSkysetupWithDatas:self.homeInfoModel.pts];
        } break;
        case 1: {
            headerCell.title = @"籃板";
            [playerCell waterSkysetupWithDatas:self.homeInfoModel.reb];
            [teamCell waterSkysetupWithDatas:self.homeInfoModel.reb];
        } break;
        case 2: {
            headerCell.title = @"助攻";
            [playerCell waterSkysetupWithDatas:self.homeInfoModel.ast];
            [teamCell waterSkysetupWithDatas:self.homeInfoModel.ast];
        } break;
        case 3: {
            headerCell.title = @"抄截";
            [playerCell waterSkysetupWithDatas:self.homeInfoModel.stl];
            [teamCell waterSkysetupWithDatas:self.homeInfoModel.stl];
        } break;
        case 4: {
            headerCell.title = @"阻攻";
            [playerCell waterSkysetupWithDatas:self.homeInfoModel.blk];
            [teamCell waterSkysetupWithDatas:self.homeInfoModel.blk];
        } break;
        case 5: {
            headerCell.title = @"失誤";
            [playerCell waterSkysetupWithDatas:self.homeInfoModel.turnover];
            [teamCell waterSkysetupWithDatas:self.homeInfoModel.turnover];
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
    SkyBallHetiRedHTDataMoreViewController *moreVc = [SkyBallHetiRedHTDataMoreViewController waterSkyviewController];
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
            [title appendString:@"抄截"];
        } break;
        case 4: {
            moreVc.subType = @"blk";
            [title appendString:@"阻攻"];
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
        [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTDataHomePlayerCell" bundle:nil]
             forCellReuseIdentifier:@"SkyBallHetiRedHTDataHomePlayerCell"];
    } else {
        [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTDataHomeTeamCell" bundle:nil]
             forCellReuseIdentifier:@"SkyBallHetiRedHTDataHomeTeamCell"];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"SkyBallHetiRedHTDataHomeHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"SkyBallHetiRedHTDataHomeHeaderCell"];
    kWeakSelf
    self.tableView.mj_header = [SkyBallHetiRedMJRefreshGenerator bj_headerWithRefreshingBlock:^{
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
    [SkyBallHetiRedHTDataHomeRequest waterSkyrequestWithType:self.type successBlock:^(SkyBallHetiRedHTDataHomeInfoModel *infoModel) {
        self.homeInfoModel = infoModel;
        [self refreshUI];
        if (infoModel.pts.count == 0) {
            [self.view showEmptyViewWithTitle:@"暫無數據，點擊刷新" tapBlock:^{
                [self.view hideEmptyView];
                [self.view showLoadingView];
                [self loadData];
            }];
        }
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        self.error = error;
        [self refreshUI];
    }];
}
@end
