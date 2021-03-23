#import "GlodBuleHTMatchWordLiveViewController.h"
#import "GlodBuleHTMatchLiveFeedCell.h"
#import "UIColor+GlodBuleHex.h"
#import "HTWordLive2Request.h"

@interface GlodBuleHTMatchWordLiveViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) NSArray<GlodBuleHTMatchLiveFeedModel *> *liveFeedList;

@property (nonatomic, strong) NSArray<GlodBuleHTMatchLiveFeedModel *> *showLiveFeedList;

@property (nonatomic, weak) GlodBuleHTMatchSummaryModel * summaryModel;

@property (nonatomic, strong)HTWordLive2Request *request;
@property (nonatomic, strong) GlodBuleBJError *error;
@property (nonatomic, copy)NSString *gameId;

@property (nonatomic, assign) BOOL wordLiveRequestDone;

@property (weak, nonatomic) IBOutlet UILabel *teamPtsps;

@property (nonatomic)BOOL isLiving;

@end
@implementation GlodBuleHTMatchWordLiveViewController
+ (instancetype)taoviewController {
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
- (void)taorefreshWithLiveFeedList:(NSArray<GlodBuleHTMatchLiveFeedModel *> *)liveFeedList summary:(GlodBuleHTMatchSummaryModel *)summaryModel gameId:(NSString *)gameId {
    [self.tableView.mj_header endRefreshing];
    self.liveFeedList = liveFeedList;
    self.summaryModel = summaryModel;
    self.gameId = gameId;
    [self loadData];
   // [self.tableView reloadData];
    
    if ([self.summaryModel.scheduleStatus isEqualToString:@"Final"]) {
        self.teamPtsps.text = [NSString stringWithFormat:@"已结束 %@-%@",summaryModel.away_pts, summaryModel.home_pts];
    }else if ([self.summaryModel.scheduleStatus isEqualToString:@"InProgress"]) {
        self.isLiving = YES;
    }else{
//        @"未開始"
        self.teamPtsps.text = [NSString stringWithFormat:@"未開始"];
    }
}
- (void)setupViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.estimatedRowHeight = 50;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;//自动
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GlodBuleHTMatchLiveFeedCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([GlodBuleHTMatchLiveFeedCell class])];
    kWeakSelf
    self.tableView.mj_header = [GlodBuleMJRefreshGenerator bj_headerWithRefreshingBlock:^{
        weakSelf.tableView.mj_footer.hidden = YES;
        if (weakSelf.onTableHeaderRefreshBlock) {
            weakSelf.onTableHeaderRefreshBlock();
        }
    }];
    
    self.tableView.mj_footer = [GlodBuleMJRefreshGenerator bj_foorterWithRefreshingBlock:^{
        weakSelf.tableView.mj_header.hidden = YES;
        [weakSelf loadNextPage];
    }];
}

- (void)loadData {
    self.wordLiveRequestDone = NO;

    if (!self.gameId) {
        return;
    }
    kWeakSelf
    [self.view showLoadingView];
    [self.request getWordLiveFeedWithGameId:self.gameId
                                      first:YES
                               successBlock:^(NSArray<GlodBuleHTMatchLiveFeedModel *> * _Nonnull newsList) {
        [self.view hideLoadingView];
        weakSelf.error = nil;
        weakSelf.wordLiveRequestDone = YES;
        weakSelf.showLiveFeedList = newsList;
        [weakSelf refreshUI];
        
        if (self.isLiving) {
            
            self.teamPtsps.text = [NSString stringWithFormat:@"第%@節 %@-%@",newsList[0].quarter,newsList[0].awayPts, newsList[0].homePts];
        }
        
    } errorBlock:^(GlodBuleBJError *error) {
        weakSelf.error = error;
        weakSelf.wordLiveRequestDone = YES;
        [weakSelf refreshUI];
    }];
}

- (void)loadNextPage {
    self.wordLiveRequestDone = NO;
    kWeakSelf
    [self.request getWordLiveFeedWithGameId:self.gameId
                                      first:NO
                               successBlock:^(NSArray<GlodBuleHTMatchLiveFeedModel *> * _Nonnull newsList) {
        weakSelf.error = nil;
        weakSelf.wordLiveRequestDone = YES;
        weakSelf.showLiveFeedList = newsList;
        [weakSelf refreshUI];
    } errorBlock:^(GlodBuleBJError *error) {
        weakSelf.error = error;
        weakSelf.wordLiveRequestDone = YES;
        [weakSelf refreshUI];
    }];
}

- (void)refreshUI {
    if (!self.wordLiveRequestDone) {
        return;
    }
    [self.view hideLoadingView];
    [self.view hideEmptyView];
    [self.tableView.mj_header endRefreshing];
    if (self.request.hasMore) {
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.error) {
        if (!self.showLiveFeedList) {
            kWeakSelf
            [self.view showEmptyViewWithTitle:@"獲取失敗，點擊重試" tapBlock:^{
                [weakSelf.view hideEmptyView];
                [weakSelf.view showLoadingView];
                [weakSelf loadData];
            }];
        } else {
            [self.view showToast:self.error.msg];
        }
        self.error = nil;
    }
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = NO;
    [self.tableView reloadData];
}

#pragma mark - lazy load
- (HTWordLive2Request *)request {
    if (!_request) {
        _request = [[HTWordLive2Request alloc] init];
    }
    return _request;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.showLiveFeedList) {
        return 0;
    }
    return self.showLiveFeedList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GlodBuleHTMatchLiveFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GlodBuleHTMatchLiveFeedCell class])];
    [cell taosetupWithMatchLiveFeedModel:self.showLiveFeedList[indexPath.row] summary:self.summaryModel];
//    if (indexPath.row % 2 == 0) {
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//    } else {
//        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"f9f9fb"];
//    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
