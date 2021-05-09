#import "GlodBuleHTHomeLeftViewController.h"
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
#import "GlodBuleHTLeftMeCenterItemsCell.h"

@interface GlodBuleHTHomeLeftViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger messageCount;
@end
@implementation GlodBuleHTHomeLeftViewController
+ (instancetype)taoviewController {
    return [[GlodBuleHTHomeLeftViewController alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我的";
    [self.navigationController.navigationBar setupBackground];
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self setupTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onUserLogStatusChagne)
                                                 name:kUserLogStatusChagneNotice
                                               object:nil];
    [GlodBuleHTUserRequest taorequestUnReadMessageCountWithSuccessBlock:^(NSInteger count) {
        self.messageCount = count;
        [self.tableView reloadData];
    } failBlock:nil];
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
    self.tableView.estimatedRowHeight = 80;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
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
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTLeftMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([GlodBuleHTLeftMeCenterItemsCell class])];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.row == 0) {
        GlodBuleHTMeCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMeCenterHeaderCell class])];
        [cell tao_refreshUI];
        return cell;
    }
    if (indexPath.row == 1) {
        GlodBuleHTLeftMeCenterItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTLeftMeCenterItemsCell class])];
        cell.onItemTappedBlock = ^(NSInteger index) {
            UIViewController *viewController;
            switch (index) {
                case 0: {
                    //viewController = [GlodBuleHTCollectionViewController taoviewController];
                } break;
                case 1: {
                   // viewController = [GlodBuleHTCommentViewController taoviewController];
                } break;
                case 2: {
                    //viewController = [GlodBuleHTLikeViewController taoviewController];
                } break;
                case 3: {
                   // viewController = [GlodBuleHTHistoryViewController taoviewController];
                } break;
                default:
                    break;
            }
//            [weakSelf.navigationController pushViewController:viewController animated:YES];
            [self sendAction:index + 1];
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
    if (![GlodBuleHTUserManager tao_isUserLogin]) {
        [GlodBuleHTUserManager tao_doUserLogin];
        return;
    }
    UIViewController *viewController;
    if (indexPath.row == 0) {
//        viewController = [GlodBuleHTUserInfoEditViewController taoviewController];
        [self sendAction:0];
    }
    if (indexPath.row == 2) {
//        viewController = [GlodBuleHTMessageViewController taoviewController];
        [self sendAction:5];
    }
    if (indexPath.row == 3) {
//        viewController = [GlodBuleHTSettingViewController taoviewController];
        [self sendAction:6];
    }
//    [self.navigationController pushViewController:viewController animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 110;
    }
    if (indexPath.row == 1) {
        return 260;
    }
    return 55;
}

-(void)sendAction:(NSInteger)index
{
    [[NSNotificationCenter defaultCenter] postNotificationName:left_controller_click_name object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%d", index]}];
}
@end
