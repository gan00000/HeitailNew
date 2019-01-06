#import "HBMatchCompareViewController.h"
#import "HBMatchQuarterCell.h"
#import "HBMatchPtsCompareCell.h"
#import "HBMatchBestPlayerCell.h"
@interface HBMatchCompareViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) HBMatchSummaryModel *summaryModel;
@end
@implementation HBMatchCompareViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchCompare");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)refreshWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel {
    [self.tableView.mj_header endRefreshing];
    self.summaryModel = summaryModel;
    [self.tableView reloadData];
}
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBMatchQuarterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBMatchQuarterCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBMatchPtsCompareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBMatchPtsCompareCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBMatchBestPlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBMatchBestPlayerCell class])];
    kWeakSelf
    self.tableView.mj_header = [HBMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HBMatchQuarterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBMatchQuarterCell class])];
        [cell setupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 1) {
        HBMatchPtsCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBMatchPtsCompareCell class])];
        [cell setupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    HBMatchBestPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBMatchBestPlayerCell class])];
    [cell setupWithMatchSummaryModel:self.summaryModel];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 105;
    }
    if (indexPath.section == 1) {
        return 320;
    }
    return 260;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 10;
    }
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
@end
