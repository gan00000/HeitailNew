#import "KSasxHTTabBarHomeViewController.h"
#import "FFlaliHTUserInfoEditViewController.h"
#import "WSKggHTCollectionViewController.h"
#import "YeYeeHTCommentViewController.h"
#import "KSasxHTLikeViewController.h"
#import "BByasHTHistoryViewController.h"
#import "NSNiceHTMessageViewController.h"
#import "FFlaliHTSettingViewController.h"
#import "TuTuosHTMeCenterHeaderCell.h"
#import "FFlaliHTMeCenterItemsCell.h"
#import "UUaksHTMeCenterNormalCell.h"
#import "TuTuosHTUserRequest.h"
@interface KSasxHTTabBarHomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger messageCount;
@end
@implementation KSasxHTTabBarHomeViewController
+ (instancetype)taoviewController {
    return [[KSasxHTTabBarHomeViewController alloc] init];
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
    [TuTuosHTUserRequest taorequestUnReadMessageCountWithSuccessBlock:^(NSInteger count) {
        self.messageCount = count;
        [self.tableView reloadData];
    } failBlock:nil];
    self.taomeCenterButton.hidden = YES;
}


- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"KSasxHTTabBarHomeViewController viewDidAppear");
    [self.tableView reloadData];
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TuTuosHTMeCenterHeaderCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([TuTuosHTMeCenterHeaderCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FFlaliHTMeCenterItemsCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([FFlaliHTMeCenterItemsCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UUaksHTMeCenterNormalCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([UUaksHTMeCenterNormalCell class])];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf
    if (indexPath.row == 0) {
        TuTuosHTMeCenterHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TuTuosHTMeCenterHeaderCell class])];
        [cell tao_refreshUI];
        return cell;
    }
    if (indexPath.row == 1) {
        FFlaliHTMeCenterItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FFlaliHTMeCenterItemsCell class])];
        cell.onItemTappedBlock = ^(NSInteger index) {
            UIViewController *viewController;
            switch (index) {
                    case 0: {
                        viewController = [WSKggHTCollectionViewController taoviewController];
                    } break;
                    case 1: {
                        viewController = [YeYeeHTCommentViewController taoviewController];
                    } break;
                    case 2: {
                        viewController = [KSasxHTLikeViewController taoviewController];
                    } break;
                    case 3: {
                        viewController = [BByasHTHistoryViewController taoviewController];
                    } break;
                default:
                    break;
            }
            [weakSelf.navigationController pushViewController:viewController animated:YES];
        };
        return cell;
    }
    if (indexPath.row == 2) {
        UUaksHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UUaksHTMeCenterNormalCell class])];
        cell.title = @"消息通知";
        cell.messageCount = self.messageCount;
        return cell;
    }
    UUaksHTMeCenterNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UUaksHTMeCenterNormalCell class])];
    cell.title = @"系統設置";
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![NSNiceHTUserManager tao_isUserLogin]) {
        [NSNiceHTUserManager tao_doUserLogin];
        return;
    }
    UIViewController *viewController;
    if (indexPath.row == 0) {
        viewController = [FFlaliHTUserInfoEditViewController taoviewController];
    }
    if (indexPath.row == 2) {
        viewController = [NSNiceHTMessageViewController taoviewController];
    }
    if (indexPath.row == 3) {
        viewController = [FFlaliHTSettingViewController taoviewController];
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
