#import "SkyBallHetiRedHTMatchCompareViewController.h"
#import "SkyBallHetiRedHTMatchQuarterCell.h"
#import "SkyBallHetiRedHTMatchPtsCompareCell.h"
#import "SkyBallHetiRedHTMatchBestPlayerCell.h"
#import "HTScoreViewCell.h"

@interface SkyBallHetiRedHTMatchCompareViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) SkyBallHetiRedHTMatchSummaryModel *summaryModel;
@property (nonatomic, weak)NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *liveFeedModel;
@end
@implementation SkyBallHetiRedHTMatchCompareViewController
+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedMatchCompare");
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
- (void)waterSkyrefreshWithMatchSummaryModel:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *)liveFeedModel{
    [self.tableView.mj_header endRefreshing];
    self.summaryModel = summaryModel;
    self.liveFeedModel = liveFeedModel;
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SkyBallHetiRedHTMatchQuarterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SkyBallHetiRedHTMatchQuarterCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SkyBallHetiRedHTMatchPtsCompareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SkyBallHetiRedHTMatchPtsCompareCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SkyBallHetiRedHTMatchBestPlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SkyBallHetiRedHTMatchBestPlayerCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTScoreViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTScoreViewCell class])];
    
    kWeakSelf
    self.tableView.mj_header = [SkyBallHetiRedMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SkyBallHetiRedHTMatchQuarterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkyBallHetiRedHTMatchQuarterCell class])];
        [cell waterSkysetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 1) {
        HTScoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTScoreViewCell class])];
        //[cell waterSkysetupWithMatchSummaryModel:self.summaryModel];
        [cell setMatchSummaryModel:self.summaryModel liveFeedModel:self.liveFeedModel];
        return cell;
    }
    if (indexPath.section == 2) {
        SkyBallHetiRedHTMatchPtsCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkyBallHetiRedHTMatchPtsCompareCell class])];
        [cell waterSkysetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    SkyBallHetiRedHTMatchBestPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SkyBallHetiRedHTMatchBestPlayerCell class])];
    [cell waterSkysetupWithMatchSummaryModel:self.summaryModel];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 105;
    }
    if (indexPath.section == 1) {
        return 210;
    }
    if (indexPath.section == 2) {
        return 400;
    }
    return 450;
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
