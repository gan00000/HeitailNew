#import "HBNewsDetailViewController.h"
#import "HBNewsTopRequest.h"
#import "HBNewsHeaderCell.h"
#import "HBNewsWebCell.h"
#import "HBNewsHomeCell.h"
#import "HBNewsTopHeaderView.h"
#import "HBBJNavigationController.h"
@interface HBNewsDetailViewController () <UITableViewDelegate, UITableViewDataSource, BJNavigationDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *topNewsList;
@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, assign) CGFloat newsContentHeight;
@property (nonatomic, assign) BOOL topRequestDone;
@property (nonatomic, assign) BOOL htmlLoadDone;
@end
@implementation HBNewsDetailViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"NewsDetail");
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
    if (!self.topRequestDone || !self.htmlLoadDone) {
        return 0;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.topNewsList.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HBNewsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBNewsHeaderCell"];
        [cell setupWithNewsModel:self.newsModel];
        return cell;
    } else if (indexPath.section == 1) {
        kWeakSelf
        HBNewsWebCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBNewsWebCell"];
        [cell setupWithClearHtmlContent:self.htmlContent];
        cell.onContentHeightUpdateBlock = ^(CGFloat height) {
            if (fabs(height - weakSelf.newsContentHeight) < 1) {
                return;
            }
            weakSelf.newsContentHeight = height;
            [weakSelf.tableView reloadData];
        };
        return cell;
    }
    HBNewsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBNewsHomeCell"];
    [cell setupWithNewsModel:self.topNewsList[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        HBNewsModel *newsModel = self.topNewsList[indexPath.row];
        HBNewsDetailViewController *detailVc = [HBNewsDetailViewController viewController];
        detailVc.newsModel = newsModel;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.newsModel.detailHeaderHeight;
    } else if (indexPath.section == 1) {
        return self.newsContentHeight;
    }
    return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 40;
    }
    return 0;
}
- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        HBNewsTopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HBNewsTopHeaderView"];
        return headerView;
    }
    return nil;
}
#pragma mark - private
- (void)setupViews {
    self.title = @"新聞詳情";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"HBNewsHeaderCell" bundle:nil]
         forCellReuseIdentifier:@"HBNewsHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HBNewsWebCell" bundle:nil]
         forCellReuseIdentifier:@"HBNewsWebCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HBNewsHomeCell" bundle:nil]
         forCellReuseIdentifier:@"HBNewsHomeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HBNewsTopHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HBNewsTopHeaderView"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.newsContentHeight = 300;
    self.topRequestDone = NO;
    self.htmlLoadDone = NO;
    [self.view showLoadingView];
    if ([HBNewsModel canShare]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(onShareButtonTapped:)];
    }
}
- (void)loadData {
    kWeakSelf
    [HBNewsTopRequest requestWithSuccessBlock:^(NSArray<HBNewsModel *> *newsList) {
        weakSelf.topNewsList = newsList;
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    } errorBlock:^(HBBJError *error) {
        [weakSelf.view showToast:error.msg];
        weakSelf.topRequestDone = YES;
        [weakSelf refreshUI];
    }];
    [self.newsModel getClearContentWithBlock:^(BOOL success, NSString *content) {
        weakSelf.htmlContent = content;
        weakSelf.htmlLoadDone = YES;
        [weakSelf refreshUI];
    }];
}
- (void)refreshUI {
    if (!self.topRequestDone || !self.htmlLoadDone) {
        return;
    }
    [self.view hideLoadingView];
    [self.tableView reloadData];
}
- (void)onShareButtonTapped:(id)sender {
    [self.newsModel share];
}
#pragma mark - BJNavigationDelegate
- (BOOL)bj_shouldHandlePopActionMySelf {
    return YES;
}
- (void)bj_handlePopActionMySelf {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
