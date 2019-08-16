#import "SkyBallHetiRedHTMatchDetailViewController.h"
#import "SkyBallHetiRedHTMatchWordLiveViewController.h"
#import "SkyBallHetiRedHTMatchCompareViewController.h"
#import "SkyBallHetiRedHTMatchDashboardViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import <WebKit/WebKit.h>
#import "SkyBallHetiRedHTMatchLiveFeedRequest.h"
#import "SkyBallHetiRedHTMatchSummaryRequest.h"
#import "UIImageView+SkyBallHetiRedSVG.h"
#import "SkyBallHetiRedHTMatchVideoLiveViewController.h"

@interface SkyBallHetiRedHTMatchDetailViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamPtsLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) NSMutableArray *loadedControllersArray;
@property (nonatomic, strong) NSMutableArray *loadedFlagArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *liveFeedList;
@property (nonatomic, strong) SkyBallHetiRedHTMatchSummaryModel *matchSummaryModel;
@property (nonatomic, strong) SkyBallHetiRedHTMatchCompareModel *matchCompareModel;
@property (nonatomic, assign) BOOL feedLoaded;
@property (nonatomic, assign) BOOL summaryLoaded;
@property (nonatomic, strong) SkyBallHetiRedBJError *error;
@property (nonatomic, copy) dispatch_block_t loadedBlock;
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation SkyBallHetiRedHTMatchDetailViewController
+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedMatchDetail");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupUI];
    [self loadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopTimer];
}
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
}
#pragma mark - private
- (void)setupUI {
    self.title = [NSString stringWithFormat:@"%@ VS %@", self.matchModel.awayName, self.matchModel.homeName];
    [self.contentView addSubview:self.segmentControl];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(self.segmentControl.mas_bottom).mas_offset(1);
    }];
    self.homeTeamLogo.contentMode = UIViewContentModeScaleAspectFit;
    self.awayTeamLogo.contentMode = UIViewContentModeScaleAspectFit;
    [self segmentedValueChangedHandle:0];
    [self.view showLoadingView];
}
- (void)initData {
    
     if ([SkyBallHetiRedHTUserManager manager].showTextLive) {
         
         for (NSInteger i = 0; i < 4; i++) {
             [self.loadedFlagArray addObject:@(NO)];
             [self.loadedControllersArray addObject:@(NO)];
         }
     }else{
         
         for (NSInteger i = 0; i < 3; i++) {
             [self.loadedFlagArray addObject:@(NO)];
             [self.loadedControllersArray addObject:@(NO)];
         }
     }
    

    
    
    self.feedLoaded = YES;
    self.summaryLoaded = YES;
}
- (void)loadData {
    if (!self.feedLoaded || !self.summaryLoaded) {
        return;
    }
    self.feedLoaded = NO;
    self.summaryLoaded = NO;
    self.error = nil;
    [SkyBallHetiRedHTMatchLiveFeedRequest waterSkyrequestLiveFeedWithGameId:self.matchModel.game_id successBlock:^(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *feedList) {
        self.liveFeedList = feedList;
        self.feedLoaded = YES;
        [self refreshUI];
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        self.error = error;
        self.feedLoaded = YES;
        [self refreshUI];
    }];
    [SkyBallHetiRedHTMatchSummaryRequest waterSkyrequestSummaryWithGameId:self.matchModel.game_id successBlock:^(SkyBallHetiRedHTMatchSummaryModel *summaryModel, SkyBallHetiRedHTMatchCompareModel *compareModel) {
        self.matchSummaryModel = summaryModel;
        self.matchCompareModel = compareModel;
        self.summaryLoaded = YES;
        [self refreshUI];
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        self.error = error;
        self.summaryLoaded = YES;
        [self refreshUI];
    }];
}
- (void)refreshUI {
    if (!self.feedLoaded || !self.summaryLoaded) {
        return;
    }
    [self.view hideLoadingView];
    if (self.error) {
        if (!self.liveFeedList || !self.matchSummaryModel) {
            kWeakSelf
            [self.view showEmptyViewWithTitle:@"加載失敗，點擊重試" tapBlock:^{
                [weakSelf.view hideEmptyView];
                [weakSelf.view showLoadingView];
                [weakSelf loadData];
            }];
        }
        [self.view showToast:self.error.msg];
    }
    self.homeTeamLogo.hidden = YES;
    self.awayTeamLogo.hidden = YES;
    self.homeTeamLogo.hidden = NO;
    if ([self.matchSummaryModel.homeLogo hasSuffix:@"svg"]) {
        [self.homeTeamLogo svg_setImageWithURL:[NSURL URLWithString:self.matchSummaryModel.homeLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }else{
        [self.homeTeamLogo sd_setImageWithURL:[NSURL URLWithString:self.matchSummaryModel.homeLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }
    self.homeTeamPtsLabel.text = self.matchSummaryModel.home_pts;
    self.awayTeamLogo.hidden = NO;
    if ([self.matchSummaryModel.awayLogo hasSuffix:@"svg"]) {
        [self.awayTeamLogo svg_setImageWithURL:[NSURL URLWithString:self.matchSummaryModel.awayLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }else{
        [self.awayTeamLogo sd_setImageWithURL:[NSURL URLWithString:self.matchSummaryModel.awayLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }
    self.awayTeamPtsLabel.text = self.matchSummaryModel.away_pts;
    self.timeLabel.hidden = YES;
    if (self.matchSummaryModel.game_status == 1) {
        self.statusLabel.text = @"已結束";
        [self stopTimer];
    } else if ([self.matchSummaryModel.scheduleStatus isEqualToString:@"Final"]) {
        self.statusLabel.text = @"已結束";
        [self stopTimer];
    } else if ([self.matchSummaryModel.scheduleStatus isEqualToString:@"InProgress"]) {
        self.statusLabel.text = [NSString stringWithFormat:@"第%@節", self.matchSummaryModel.quarter];
        if ([self.matchSummaryModel.quarter isEqualToString:@"OT"]) {
            self.statusLabel.text = self.matchSummaryModel.quarter;
        }
        self.timeLabel.text = self.matchSummaryModel.time;
        [self startTimer];
    } else if ([self.matchSummaryModel.scheduleStatus isEqualToString:@"Canceled"]) {
        self.statusLabel.text = @"已取消";
    } else if ([self.matchSummaryModel.scheduleStatus isEqualToString:@"Postponed"]) {
        self.statusLabel.text = @"未開始";
    } else {
        self.statusLabel.text = @"未開始";
    }
    [self segmentedValueChangedHandle:self.currentIndex];
    if (self.loadedBlock) {
        self.loadedBlock();
    }
}
- (void)startTimer {
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                  target:self
                                                selector:@selector(loadData)
                                                userInfo:nil
                                                 repeats:YES];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSInteger page = offset.x / SCREEN_WIDTH;
    self.currentIndex = page;
    [self loadChildViewControllerByIndex:page];
    [self.segmentControl setSelectedSegmentIndex:page animated:YES];
}
#pragma mark -- HMSegmentedControl Action
- (void)segmentedValueChangedHandle:(NSInteger)index {
    self.currentIndex = index;
    [self loadChildViewControllerByIndex:index];
    [self.containerView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
}
- (void)loadChildViewControllerByIndex:(NSInteger)index {
    
    //显示文字直播
     if ([SkyBallHetiRedHTUserManager manager].showTextLive) {
         
         if ([self.loadedFlagArray[index] boolValue]) {
             if (index == 0) {

                 SkyBallHetiRedHTMatchVideoLiveViewController *detailVc =  self.loadedControllersArray[index];//[SkyBallHetiRedHTMatchVideoLiveViewController waterSkyviewController];
                 detailVc.game_id = self.matchModel.game_id;
                 
                 
             } else if (index == 1) {
                 SkyBallHetiRedHTMatchWordLiveViewController *wordVc = self.loadedControllersArray[index];
                 [wordVc waterSkyrefreshWithLiveFeedList:self.liveFeedList];
                 
             }else if (index == 2) {
                 SkyBallHetiRedHTMatchCompareViewController *compareVc = self.loadedControllersArray[index];
                 [compareVc waterSkyrefreshWithMatchSummaryModel:self.matchSummaryModel];
             } else {
                 SkyBallHetiRedHTMatchDashboardViewController *dashbdVc = self.loadedControllersArray[index];
                 [dashbdVc waterSkyrefreshWithMatchCompareModel:self.matchCompareModel];
             }
             return;
         }
         kWeakSelf
         UIViewController *vc;
         if (index == 0) {
 
             
             //视频直播
             SkyBallHetiRedHTMatchVideoLiveViewController *detailVc = [SkyBallHetiRedHTMatchVideoLiveViewController waterSkyviewController];
             detailVc.game_id = self.matchModel.game_id;
             vc = detailVc;
             
             
             
         } else if (index == 1) {
             
             SkyBallHetiRedHTMatchWordLiveViewController *wordVc = [SkyBallHetiRedHTMatchWordLiveViewController waterSkyviewController];
             wordVc.onTableHeaderRefreshBlock = ^{
                 [weakSelf loadData];
             };
             vc = wordVc;
             
         }else if (index == 2) {
             SkyBallHetiRedHTMatchCompareViewController *compareVc = [SkyBallHetiRedHTMatchCompareViewController waterSkyviewController];
             [compareVc waterSkyrefreshWithMatchSummaryModel:self.matchSummaryModel];
             compareVc.onTableHeaderRefreshBlock = ^{
                 [weakSelf loadData];
             };
             vc = compareVc;
         } else {
             SkyBallHetiRedHTMatchDashboardViewController *dashboardVc = [SkyBallHetiRedHTMatchDashboardViewController waterSkyviewController];
             [dashboardVc waterSkyrefreshWithMatchCompareModel:self.matchCompareModel];
             vc = dashboardVc;
         }
         [self addChildViewController:vc];
         [self.containerView addSubview:vc.view];
         [self.loadedFlagArray replaceObjectAtIndex:index withObject:@(YES)];
         [self.loadedControllersArray replaceObjectAtIndex:index withObject:vc];
         [self setChildViewFrame:vc.view byIndex:index];
         
         [weakSelf loadData];
         return;
     }
    
    //不显示文字直播
    if ([self.loadedFlagArray[index] boolValue]) {
        if (index == 0) {
//            SkyBallHetiRedHTMatchWordLiveViewController *wordVc = self.loadedControllersArray[index];
//            [wordVc waterSkyrefreshWithLiveFeedList:self.liveFeedList];
            
            
            SkyBallHetiRedHTMatchVideoLiveViewController *detailVc = self.loadedControllersArray[index];//[SkyBallHetiRedHTMatchVideoLiveViewController waterSkyviewController];
            detailVc.game_id = self.matchModel.game_id;
           

        } else if (index == 1) {
            SkyBallHetiRedHTMatchCompareViewController *compareVc = self.loadedControllersArray[index];
            [compareVc waterSkyrefreshWithMatchSummaryModel:self.matchSummaryModel];
        } else {
            SkyBallHetiRedHTMatchDashboardViewController *dashbdVc = self.loadedControllersArray[index];
            [dashbdVc waterSkyrefreshWithMatchCompareModel:self.matchCompareModel];
        }
        return;
    }
    kWeakSelf
    UIViewController *vc;
    if (index == 0) {
//        SkyBallHetiRedHTMatchWordLiveViewController *wordVc = [SkyBallHetiRedHTMatchWordLiveViewController waterSkyviewController];
//        wordVc.onTableHeaderRefreshBlock = ^{
//            [weakSelf loadData];
//        };
//        vc = wordVc;
        
        //视频直播
        SkyBallHetiRedHTMatchVideoLiveViewController *detailVc = [SkyBallHetiRedHTMatchVideoLiveViewController waterSkyviewController];
        detailVc.game_id = self.matchModel.game_id;
        vc = detailVc;
        

        
    } else if (index == 1) {
        SkyBallHetiRedHTMatchCompareViewController *compareVc = [SkyBallHetiRedHTMatchCompareViewController waterSkyviewController];
        [compareVc waterSkyrefreshWithMatchSummaryModel:self.matchSummaryModel];
        compareVc.onTableHeaderRefreshBlock = ^{
            [weakSelf loadData];
        };
        vc = compareVc;
    } else {
        SkyBallHetiRedHTMatchDashboardViewController *dashboardVc = [SkyBallHetiRedHTMatchDashboardViewController waterSkyviewController];
        [dashboardVc waterSkyrefreshWithMatchCompareModel:self.matchCompareModel];
        vc = dashboardVc;
    }
    [self addChildViewController:vc];
    [self.containerView addSubview:vc.view];
    [self.loadedFlagArray replaceObjectAtIndex:index withObject:@(YES)];
    [self.loadedControllersArray replaceObjectAtIndex:index withObject:vc];
    [self setChildViewFrame:vc.view byIndex:index];
    [weakSelf loadData];
    
}
- (void)setChildViewFrame:(UIView *)childView byIndex:(NSInteger)index {
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView);
        make.width.equalTo(self.containerView);
        make.height.equalTo(self.containerView);
        make.left.equalTo(self.containerView).offset(index * SCREEN_WIDTH);
    }];
}
#pragma mark -- lazy load
- (NSMutableArray *)loadedFlagArray {
    if (!_loadedFlagArray) {
        _loadedFlagArray = [NSMutableArray array];
    }
    return _loadedFlagArray;
}
- (NSMutableArray *)loadedControllersArray {
    if (!_loadedControllersArray) {
        _loadedControllersArray = [NSMutableArray array];
    }
    return _loadedControllersArray;
}
- (HMSegmentedControl *)segmentControl {
    if (!_segmentControl) {

        
        if ([SkyBallHetiRedHTUserManager manager].showTextLive) {
            
                    _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"視頻直播", @"文字直播", @"對陣", @"數據統計"]];
            
        }else{
               _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"視頻直播", @"對陣", @"數據統計"]];
        }
      
        _segmentControl.selectionIndicatorColor = [UIColor hx_colorWithHexRGBAString:@"fc562e"];
        _segmentControl.selectionIndicatorHeight = 3.0f;
        _segmentControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -8, 0, -18);
        _segmentControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"666666"]};
        _segmentControl.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"fc562e"]};
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        kWeakSelf
        _segmentControl.indexChangeBlock = ^(NSInteger index){
            [weakSelf segmentedValueChangedHandle:index];
        };
    }
    return _segmentControl;
}
- (UIScrollView *)containerView {
    if (!_containerView) {
        _containerView = [[UIScrollView alloc] init];
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.delegate = self;
        _containerView.pagingEnabled = YES;
        _containerView.autoresizingMask = UIViewAutoresizingNone;
        _containerView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT - 64 - SCREEN_HEIGHT - 1);
        _containerView.bounces = NO;
    }
    return _containerView;
}
@end
