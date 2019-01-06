#import "HBMatchWordLiveViewController.h"
#import "HBMatchLiveFeedCell.h"
@interface HBMatchWordLiveViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) NSArray<HBMatchLiveFeedModel *> *liveFeedList;
@end
@implementation HBMatchWordLiveViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(@"MatchWordLive");
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
- (void)refreshWithLiveFeedList:(NSArray<HBMatchLiveFeedModel *> *)liveFeedList {
    [self.tableView.mj_header endRefreshing];
    self.liveFeedList = liveFeedList;
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBMatchLiveFeedCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HBMatchLiveFeedCell class])];
    kWeakSelf
    self.tableView.mj_header = [HBMJRefreshGenerator bj_headerWithRefreshingBlock:^{
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
    HBMatchLiveFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HBMatchLiveFeedCell class])];
    [cell setupWithMatchLiveFeedModel:self.liveFeedList[indexPath.row]];
    return cell;
}
@end
