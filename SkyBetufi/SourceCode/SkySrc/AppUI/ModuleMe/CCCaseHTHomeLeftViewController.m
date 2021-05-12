#import "CCCaseHTHomeLeftViewController.h"
#import "GGCatHTUserInfoEditViewController.h"
#import "RRDogHTCollectionViewController.h"
#import "KMonkeyHTCommentViewController.h"
#import "CCCaseHTLikeViewController.h"
#import "CCCaseHTHistoryViewController.h"
#import "CCCaseHTMessageViewController.h"
#import "NDeskHTSettingViewController.h"
#import "HourseHTMeCenterHeaderCell.h"
#import "HourseHTMeCenterItemsCell.h"
#import "SundayHTMeCenterNormalCell.h"
#import "HourseHTUserRequest.h"
#import "KMonkeyHTLeftMeCenterItemsCell.h"

@interface CCCaseHTHomeLeftViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger messageCount;
@end
@implementation CCCaseHTHomeLeftViewController
+ (instancetype)taoviewController {
    return [[CCCaseHTHomeLeftViewController alloc] init];
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
    [HourseHTUserRequest taorequestUnReadMessageCountWithSuccessBlock:^(NSInteger count) {
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HourseHTMeCenterHeaderCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([HourseHTMeCenterHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HourseHTMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([HourseHTMeCenterItemsCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SundayHTMeCenterNormalCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([SundayHTMeCenterNormalCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KMonkeyHTLeftMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([KMonkeyHTLeftMeCenterItemsCell class])];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.row == 0) {
        HourseHTMeCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HourseHTMeCenterHeaderCell class])];
        [cell tao_refreshUI];
        return cell;
    }
    if (indexPath.row == 1) {
        KMonkeyHTLeftMeCenterItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KMonkeyHTLeftMeCenterItemsCell class])];
        cell.onItemTappedBlock = ^(NSInteger index) {
            UIViewController *viewController;
            switch (index) {
                case 0: {
                    //viewController = [RRDogHTCollectionViewController taoviewController];
                } break;
                case 1: {
                   // viewController = [KMonkeyHTCommentViewController taoviewController];
                } break;
                case 2: {
                    //viewController = [CCCaseHTLikeViewController taoviewController];
                } break;
                case 3: {
                   // viewController = [CCCaseHTHistoryViewController taoviewController];
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
        SundayHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SundayHTMeCenterNormalCell class])];
        cell.title = @"消息通知";
        cell.messageCount = self.messageCount;
        return cell;
    }
    SundayHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SundayHTMeCenterNormalCell class])];
    cell.title = @"系統設置";
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![MMTodayHTUserManager tao_isUserLogin]) {
        [MMTodayHTUserManager tao_doUserLogin];
        return;
    }
    UIViewController *viewController;
    if (indexPath.row == 0) {
//        viewController = [GGCatHTUserInfoEditViewController taoviewController];
        [self sendAction:0];
    }
    if (indexPath.row == 2) {
//        viewController = [CCCaseHTMessageViewController taoviewController];
        [self sendAction:5];
    }
    if (indexPath.row == 3) {
//        viewController = [NDeskHTSettingViewController taoviewController];
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
