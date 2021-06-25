#import "BlysaHTHomeLeftViewController.h"
#import "WSKggHTUserInfoEditViewController.h"
#import "CfipyHTCollectionViewController.h"
#import "FFlaliHTCommentViewController.h"
#import "BlysaHTLikeViewController.h"
#import "UUaksHTHistoryViewController.h"
#import "KSasxHTMessageViewController.h"
#import "NSNiceHTSettingViewController.h"
#import "UUaksHTMeCenterHeaderCell.h"
#import "UUaksHTMeCenterItemsCell.h"
#import "CfipyHTMeCenterNormalCell.h"
#import "NSNiceHTUserRequest.h"
#import "CfipyHTLeftMeCenterItemsCell.h"

@interface BlysaHTHomeLeftViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger messageCount;
@end
@implementation BlysaHTHomeLeftViewController
+ (instancetype)taoviewController {
    return [[BlysaHTHomeLeftViewController alloc] init];
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
    [NSNiceHTUserRequest taorequestUnReadMessageCountWithSuccessBlock:^(NSInteger count) {
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UUaksHTMeCenterHeaderCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([UUaksHTMeCenterHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UUaksHTMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([UUaksHTMeCenterItemsCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CfipyHTMeCenterNormalCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([CfipyHTMeCenterNormalCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CfipyHTLeftMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([CfipyHTLeftMeCenterItemsCell class])];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.row == 0) {
        UUaksHTMeCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UUaksHTMeCenterHeaderCell class])];
        [cell tao_refreshUI];
        return cell;
    }
    if (indexPath.row == 1) {
        CfipyHTLeftMeCenterItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CfipyHTLeftMeCenterItemsCell class])];
        cell.onItemTappedBlock = ^(NSInteger index) {
            UIViewController *viewController;
            switch (index) {
                case 0: {
                    //viewController = [CfipyHTCollectionViewController taoviewController];
                } break;
                case 1: {
                   // viewController = [FFlaliHTCommentViewController taoviewController];
                } break;
                case 2: {
                    //viewController = [BlysaHTLikeViewController taoviewController];
                } break;
                case 3: {
                   // viewController = [UUaksHTHistoryViewController taoviewController];
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
        CfipyHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CfipyHTMeCenterNormalCell class])];
        cell.title = @"消息通知";
        cell.messageCount = self.messageCount;
        return cell;
    }
    CfipyHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CfipyHTMeCenterNormalCell class])];
    cell.title = @"系統設置";
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![TuTuosHTUserManager tao_isUserLogin]) {
        [TuTuosHTUserManager tao_doUserLogin];
        return;
    }
    UIViewController *viewController;
    if (indexPath.row == 0) {
//        viewController = [WSKggHTUserInfoEditViewController taoviewController];
        [self sendAction:0];
    }
    if (indexPath.row == 2) {
//        viewController = [KSasxHTMessageViewController taoviewController];
        [self sendAction:5];
    }
    if (indexPath.row == 3) {
//        viewController = [NSNiceHTSettingViewController taoviewController];
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

- (BOOL)tao_shouldHandlePopActionMySelf{
    return YES;
}
- (void)tao_handlePopActionMySelf
{
    [[CfipyPPXXBJViewControllerCenter mainViewController].drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
@end
