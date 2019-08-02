#import "SkyBallHetiRedHTTabBarHomeViewController.h"
#import "SkyBallHetiRedHTUserInfoEditViewController.h"
#import "SkyBallHetiRedHTCollectionViewController.h"
#import "SkyBallHetiRedHTCommentViewController.h"
#import "SkyBallHetiRedHTLikeViewController.h"
#import "SkyBallHetiRedHTHistoryViewController.h"
#import "SkyBallHetiRedHTMessageViewController.h"
#import "SkyBallHetiRedHTSettingViewController.h"
#import "SkyBallHetiRedHTMeCenterHeaderCell.h"
#import "SkyBallHetiRedHTMeCenterItemsCell.h"
#import "SkyBallHetiRedHTMeCenterNormalCell.h"
#import "SkyBallHetiRedHTUserRequest.h"
@interface SkyBallHetiRedHTTabBarHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger messageCount;
@end
@implementation SkyBallHetiRedHTTabBarHomeViewController
+ (instancetype)waterSkyviewController {
    return [[SkyBallHetiRedHTTabBarHomeViewController alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self.navigationController.navigationBar setupBackground];
    [self setupTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUserLogStatusChagne)
                                                 name:kUserLogStatusChagneNotice
                                               object:nil];
    [SkyBallHetiRedHTUserRequest waterSkyrequestUnReadMessageCountWithSuccessBlock:^(NSInteger count) {
        self.messageCount = count;
        [self.tableView reloadData];
    } failBlock:nil];
    self.waterSkymeCenterButton.hidden = YES;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)onUserLogStatusChagne {
    [self.tableView reloadData];
}
- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SkyBallHetiRedHTMeCenterHeaderCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([SkyBallHetiRedHTMeCenterHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SkyBallHetiRedHTMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([SkyBallHetiRedHTMeCenterItemsCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SkyBallHetiRedHTMeCenterNormalCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([SkyBallHetiRedHTMeCenterNormalCell class])];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.row == 0) {
        SkyBallHetiRedHTMeCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkyBallHetiRedHTMeCenterHeaderCell class])];
        [cell waterSky_refreshUI];
        return cell;
    }
    if (indexPath.row == 1) {
        SkyBallHetiRedHTMeCenterItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkyBallHetiRedHTMeCenterItemsCell class])];
        cell.onItemTappedBlock = ^(NSInteger index) {
            UIViewController *viewController;
            switch (index) {
                    case 0: {
                        viewController = [SkyBallHetiRedHTCollectionViewController waterSkyviewController];
                    } break;
                    case 1: {
                        viewController = [SkyBallHetiRedHTCommentViewController waterSkyviewController];
                    } break;
                    case 2: {
                        viewController = [SkyBallHetiRedHTLikeViewController waterSkyviewController];
                    } break;
                    case 3: {
                        viewController = [SkyBallHetiRedHTHistoryViewController waterSkyviewController];
                    } break;
                default:
                    break;
            }
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        };
        return cell;
    }
    if (indexPath.row == 2) {
        SkyBallHetiRedHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkyBallHetiRedHTMeCenterNormalCell class])];
        cell.title = @"消息通知";
        cell.messageCount = self.messageCount;
        return cell;
    }
    SkyBallHetiRedHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkyBallHetiRedHTMeCenterNormalCell class])];
    cell.title = @"系統設置";
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
        [SkyBallHetiRedHTUserManager waterSky_doUserLogin];
        return;
    }
    UIViewController *viewController;
    if (indexPath.row == 0) {
        viewController = [SkyBallHetiRedHTUserInfoEditViewController waterSkyviewController];
    }
    if (indexPath.row == 2) {
        viewController = [SkyBallHetiRedHTMessageViewController waterSkyviewController];
    }
    if (indexPath.row == 3) {
        viewController = [SkyBallHetiRedHTSettingViewController waterSkyviewController];
    }
    [self.navigationController pushViewController:viewController animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        return 110;
    }
    return 55;
}
@end
