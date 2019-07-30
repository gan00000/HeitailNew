#import "XRRFATKHTMeHomeViewController.h"
#import "XRRFATKHTUserInfoEditViewController.h"
#import "XRRFATKHTCollectionViewController.h"
#import "XRRFATKHTCommentViewController.h"
#import "XRRFATKHTLikeViewController.h"
#import "XRRFATKHTHistoryViewController.h"
#import "XRRFATKHTMessageViewController.h"
#import "XRRFATKHTSettingViewController.h"
#import "XRRFATKHTMeCenterHeaderCell.h"
#import "XRRFATKHTMeCenterItemsCell.h"
#import "XRRFATKHTMeCenterNormalCell.h"
#import "XRRFATKHTUserRequest.h"
@interface XRRFATKHTMeHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger messageCount;
@end
@implementation XRRFATKHTMeHomeViewController
+ (instancetype)skargviewController {
    return [[XRRFATKHTMeHomeViewController alloc] init];
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
    [XRRFATKHTUserRequest skargrequestUnReadMessageCountWithSuccessBlock:^(NSInteger count) {
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
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XRRFATKHTMeCenterHeaderCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([XRRFATKHTMeCenterHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XRRFATKHTMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([XRRFATKHTMeCenterItemsCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XRRFATKHTMeCenterNormalCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([XRRFATKHTMeCenterNormalCell class])];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.row == 0) {
        XRRFATKHTMeCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTMeCenterHeaderCell class])];
        [cell skarg_refreshUI];
        return cell;
    }
    if (indexPath.row == 1) {
        XRRFATKHTMeCenterItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTMeCenterItemsCell class])];
        cell.onItemTappedBlock = ^(NSInteger index) {
            UIViewController *viewController;
            switch (index) {
                case 0: {
                    viewController = [XRRFATKHTCollectionViewController skargviewController];
                } break;
                case 1: {
                    viewController = [XRRFATKHTCommentViewController skargviewController];
                } break;
                case 2: {
                    viewController = [XRRFATKHTLikeViewController skargviewController];
                } break;
                case 3: {
                    viewController = [XRRFATKHTHistoryViewController skargviewController];
                } break;
                default:
                    break;
            }
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        };
        return cell;
    }
    if (indexPath.row == 2) {
        XRRFATKHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTMeCenterNormalCell class])];
        cell.title = @"消息通知";
        cell.messageCount = self.messageCount;
        return cell;
    }
    XRRFATKHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XRRFATKHTMeCenterNormalCell class])];
    cell.title = @"系統設置";
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![XRRFATKHTUserManager skarg_isUserLogin]) {
        [XRRFATKHTUserManager skarg_doUserLogin];
        return;
    }
    UIViewController *viewController;
    if (indexPath.row == 0) {
        viewController = [XRRFATKHTUserInfoEditViewController skargviewController];
    }
    if (indexPath.row == 2) {
        viewController = [XRRFATKHTMessageViewController skargviewController];
    }
    if (indexPath.row == 3) {
        viewController = [XRRFATKHTSettingViewController skargviewController];
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
