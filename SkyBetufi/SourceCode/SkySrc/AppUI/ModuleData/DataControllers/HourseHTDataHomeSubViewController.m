#import "HourseHTDataHomeSubViewController.h"
#import "YYPackageHTDataMoreViewController.h"
#import "RRDogHTDataHomeRequest.h"
#import "SundayHTDataHomePlayerCell.h"
#import "YYPackageHTDataHomeTeamCell.h"
#import "PXFunHTDataHomeHeaderCell.h"
@interface HourseHTDataHomeSubViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CCCaseHTDataHomeInfoModel *homeInfoModel;
@property (nonatomic, strong) SundayBJError *error;
@end
@implementation HourseHTDataHomeSubViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"UKRosRedDataHomeSub");
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
    PXFunHTDataHomeHeaderCell *headerCell;
    SundayHTDataHomePlayerCell *playerCell;
    YYPackageHTDataHomeTeamCell *teamCell;
    if (indexPath.row == 0) {
        headerCell = [tableView dequeueReusableCellWithIdentifier:@"PXFunHTDataHomeHeaderCell"];
    } else {
        if (self.type == 1) {
            playerCell = [tableView dequeueReusableCellWithIdentifier:@"SundayHTDataHomePlayerCell"];
        } else {
            teamCell = [tableView dequeueReusableCellWithIdentifier:@"YYPackageHTDataHomeTeamCell"];
        }
    }
    switch (indexPath.section) {
        case 0: {
            headerCell.title = @"得分";
            [playerCell taosetupWithDatas:self.homeInfoModel.pts];
            [teamCell taosetupWithDatas:self.homeInfoModel.pts];
        } break;
        case 1: {
            headerCell.title = @"籃板";
            [playerCell taosetupWithDatas:self.homeInfoModel.reb];
            [teamCell taosetupWithDatas:self.homeInfoModel.reb];
        } break;
        case 2: {
            headerCell.title = @"助攻";
            [playerCell taosetupWithDatas:self.homeInfoModel.ast];
            [teamCell taosetupWithDatas:self.homeInfoModel.ast];
        } break;
        case 3: {
            headerCell.title = @"抄截";
            [playerCell taosetupWithDatas:self.homeInfoModel.stl];
            [teamCell taosetupWithDatas:self.homeInfoModel.stl];
        } break;
        case 4: {
            headerCell.title = @"阻攻";
            [playerCell taosetupWithDatas:self.homeInfoModel.blk];
            [teamCell taosetupWithDatas:self.homeInfoModel.blk];
        } break;
        case 5: {
            headerCell.title = @"失誤";
            [playerCell taosetupWithDatas:self.homeInfoModel.turnover];
            [teamCell taosetupWithDatas:self.homeInfoModel.turnover];
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
    YYPackageHTDataMoreViewController *moreVc = [YYPackageHTDataMoreViewController taoviewController];
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
        [self.tableView registerNib:[UINib nibWithNibName:@"SundayHTDataHomePlayerCell" bundle:nil]
             forCellReuseIdentifier:@"SundayHTDataHomePlayerCell"];
    } else {
        [self.tableView registerNib:[UINib nibWithNibName:@"YYPackageHTDataHomeTeamCell" bundle:nil]
             forCellReuseIdentifier:@"YYPackageHTDataHomeTeamCell"];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"PXFunHTDataHomeHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"PXFunHTDataHomeHeaderCell"];
    kWeakSelf
    self.tableView.mj_header = [HourseMJRefreshGenerator bj_headerWithRefreshingBlock:^{
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
    [RRDogHTDataHomeRequest taorequestWithType:self.type successBlock:^(CCCaseHTDataHomeInfoModel *infoModel) {
        self.homeInfoModel = infoModel;
        [self refreshUI];
        if (infoModel.pts.count == 0) {
            [self.view showEmptyViewWithTitle:@"暫無數據，點擊刷新" tapBlock:^{
                [self.view hideEmptyView];
                [self.view showLoadingView];
                [self loadData];
            }];
        }
    } errorBlock:^(SundayBJError *error) {
        self.error = error;
        [self refreshUI];
    }];
}
@end
