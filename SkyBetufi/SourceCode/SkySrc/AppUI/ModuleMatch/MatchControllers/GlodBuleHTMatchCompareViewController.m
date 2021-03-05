#import "GlodBuleHTMatchCompareViewController.h"
#import "GlodBuleHTMatchQuarterCell.h"
#import "GlodBuleHTMatchPtsCompareCell.h"
#import "GlodBuleHTMatchBestPlayerCell.h"
#import "GlodBuleHTScoreViewCell.h"
#import "HTHotShootCellTableViewCell.h"

@interface GlodBuleHTMatchCompareViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) GlodBuleHTMatchSummaryModel *summaryModel;
@property (nonatomic, weak)NSArray<GlodBuleHTMatchLiveFeedModel *> *liveFeedModel;
@end
@implementation GlodBuleHTMatchCompareViewController
+ (instancetype)taoviewController {
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
- (void)taorefreshWithMatchSummaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<GlodBuleHTMatchLiveFeedModel *> *)liveFeedModel{
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTMatchQuarterCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GlodBuleHTMatchQuarterCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTMatchPtsCompareCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GlodBuleHTMatchPtsCompareCell class])];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTMatchBestPlayerCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GlodBuleHTMatchBestPlayerCell class])];
   
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTScoreViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GlodBuleHTScoreViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTHotShootCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTHotShootCellTableViewCell class])];
    
    
    kWeakSelf
    self.tableView.mj_header = [GlodBuleMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        GlodBuleHTMatchQuarterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMatchQuarterCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 1) {
        GlodBuleHTScoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTScoreViewCell class])];
        //[cell taosetupWithMatchSummaryModel:self.summaryModel];
        [cell setMatchSummaryModel:self.summaryModel liveFeedModel:self.liveFeedModel];
        return cell;
    }
    if (indexPath.section == 2) {
        GlodBuleHTMatchPtsCompareCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMatchPtsCompareCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    if (indexPath.section == 3) {
        GlodBuleHTMatchBestPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMatchBestPlayerCell class])];
        [cell taosetupWithMatchSummaryModel:self.summaryModel];
        return cell;
    }
    
    HTHotShootCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTHotShootCellTableViewCell class])];

    [cell.hotShootView setDataCount:floorf(self.view.width)];
    
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
