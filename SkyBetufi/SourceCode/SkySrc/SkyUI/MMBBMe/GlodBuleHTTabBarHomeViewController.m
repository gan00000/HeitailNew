#import "GlodBuleHTTabBarHomeViewController.h"
#import "GlodBuleHTUserInfoEditViewController.h"
#import "GlodBuleHTCollectionViewController.h"
#import "GlodBuleHTCommentViewController.h"
#import "GlodBuleHTLikeViewController.h"
#import "GlodBuleHTHistoryViewController.h"
#import "GlodBuleHTMessageViewController.h"
#import "GlodBuleHTSettingViewController.h"
#import "GlodBuleHTMeCenterHeaderCell.h"
#import "GlodBuleHTMeCenterItemsCell.h"
#import "GlodBuleHTMeCenterNormalCell.h"
#import "GlodBuleHTUserRequest.h"
@interface GlodBuleHTTabBarHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger messageCount;
@end
@implementation GlodBuleHTTabBarHomeViewController
+ (instancetype)waterSkyviewController {
    return [[GlodBuleHTTabBarHomeViewController alloc] init];
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
    [GlodBuleHTUserRequest waterSkyrequestUnReadMessageCountWithSuccessBlock:^(NSInteger count) {
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTMeCenterHeaderCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([GlodBuleHTMeCenterHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([GlodBuleHTMeCenterItemsCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTMeCenterNormalCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([GlodBuleHTMeCenterNormalCell class])];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.row == 0) {
        GlodBuleHTMeCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMeCenterHeaderCell class])];
        [cell waterSky_refreshUI];
        return cell;
    }
    if (indexPath.row == 1) {
        GlodBuleHTMeCenterItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMeCenterItemsCell class])];
        cell.onItemTappedBlock = ^(NSInteger index) {
            UIViewController *viewController;
            switch (index) {
                    case 0: {
                        viewController = [GlodBuleHTCollectionViewController waterSkyviewController];
                    } break;
                    case 1: {
                        viewController = [GlodBuleHTCommentViewController waterSkyviewController];
                    } break;
                    case 2: {
                        viewController = [GlodBuleHTLikeViewController waterSkyviewController];
                    } break;
                    case 3: {
                        viewController = [GlodBuleHTHistoryViewController waterSkyviewController];
                    } break;
                default:
                    break;
            }
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        };
        return cell;
    }
    if (indexPath.row == 2) {
        GlodBuleHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMeCenterNormalCell class])];
        cell.title = @"消息通知";
        cell.messageCount = self.messageCount;
        return cell;
    }
    GlodBuleHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMeCenterNormalCell class])];
    cell.title = @"系統設置";
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![GlodBuleHTUserManager waterSky_isUserLogin]) {
        [GlodBuleHTUserManager waterSky_doUserLogin];
        return;
    }
    UIViewController *viewController;
    if (indexPath.row == 0) {
        viewController = [GlodBuleHTUserInfoEditViewController waterSkyviewController];
    }
    if (indexPath.row == 2) {
        viewController = [GlodBuleHTMessageViewController waterSkyviewController];
    }
    if (indexPath.row == 3) {
        viewController = [GlodBuleHTSettingViewController waterSkyviewController];
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
