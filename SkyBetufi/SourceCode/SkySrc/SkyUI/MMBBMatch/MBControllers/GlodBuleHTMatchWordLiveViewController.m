#import "GlodBuleHTMatchWordLiveViewController.h"
#import "GlodBuleHTMatchLiveFeedCell.h"
#import "UIColor+GlodBuleHex.h"
@interface GlodBuleHTMatchWordLiveViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) NSArray<GlodBuleHTMatchLiveFeedModel *> *liveFeedList;
@property (nonatomic, weak) GlodBuleHTMatchSummaryModel * summaryModel;
@end
@implementation GlodBuleHTMatchWordLiveViewController
+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedMatchWordLive");
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
- (void)waterSkyrefreshWithLiveFeedList:(NSArray<GlodBuleHTMatchLiveFeedModel *> *)liveFeedList summary:(GlodBuleHTMatchSummaryModel *)summaryModel {
    [self.tableView.mj_header endRefreshing];
    self.liveFeedList = liveFeedList;
    self.summaryModel = summaryModel;
    [self.tableView reloadData];
}
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTMatchLiveFeedCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GlodBuleHTMatchLiveFeedCell class])];
    kWeakSelf
    self.tableView.mj_header = [GlodBuleMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.liveFeedList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GlodBuleHTMatchLiveFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMatchLiveFeedCell class])];
    [cell waterSkysetupWithMatchLiveFeedModel:self.liveFeedList[indexPath.row] summary:self.summaryModel];
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    } else {
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"f9f9fb"];
    }
    return cell;
}
@end
