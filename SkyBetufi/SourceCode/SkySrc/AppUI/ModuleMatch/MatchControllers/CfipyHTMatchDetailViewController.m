#import "CfipyHTMatchDetailViewController.h"
#import "KSasxHTMatchWordLiveViewController.h"
#import "TuTuosHTMatchCompareViewController.h"
#import "FFlaliHTMatchDashboardViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import <WebKit/WebKit.h>
#import "FFlaliHTMatchLiveFeedRequest.h"
#import "MMoogHTMatchSummaryRequest.h"
#import "UIImageView+BlysaSVG.h"
#import "BlysaHTMatchVideoLiveViewController.h"
#import "UUaksConfigCoreUtil.h"
#import "LMPlayer.h"
#import "UUaksHTIndicatorView.h"
#import "WSKggHTIMViewController.h"
#import "TuTuosHTUserManager.h"
#import "TuTuosHTMatchWebPlayControllerViewController.h"
#import "TuTuosHTHighLightsViewController.h"
//#import <SafariServices/SFFoundation.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@import SafariServices;
@import Firebase;

@interface CfipyHTMatchDetailViewController () <UIScrollViewDelegate, LMVideoPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamName;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamName;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
//@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *startPlayImageView;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamPtsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamPtsLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *topDetailView;
@property (weak, nonatomic) IBOutlet UIView *likeContentView;
@property (weak, nonatomic) IBOutlet UIButton *leftLikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightLikeBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLikeLabel;

@property (weak, nonatomic) IBOutlet UIView *backPlayView;

@property (weak, nonatomic) IBOutlet UILabel *gameTimeLabel;


@property (nonatomic, strong) HMSegmentedControl *segmentControl;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) NSMutableArray *loadedControllersArray;
@property (nonatomic, strong) NSMutableArray *loadedFlagArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray<FFlaliHTMatchLiveFeedModel *> *liveFeedList;//对阵也会用到这数据
@property (nonatomic, strong) KSasxHTMatchSummaryModel *matchSummaryModel;
@property (nonatomic, strong) BByasHTMatchCompareModel *matchCompareModel;

@property (nonatomic,strong) WSKggHTIMViewController *imVc;

@property (nonatomic, strong) KSasxHTMacthLivePostModel *livePost;

@property (nonatomic, assign) BOOL feedLoaded;
@property (nonatomic, assign) BOOL summaryLoaded;
@property (nonatomic, strong) WSKggBJError *error;
@property (nonatomic, copy) dispatch_block_t loadedBlock;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) BlysaLMVideoPlayer *player;
@property (nonatomic, strong) BlysaLMPlayerModel *playerModel;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
/** 离开页面时候是否开始过播放 */
@property (nonatomic, assign) BOOL isStartPlay;
@property (nonatomic, strong) UIView *playerContentView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLable;
@property (nonatomic, strong)UUaksHTIndicatorView *likeIndicatorView;

@property (nonatomic, strong) NSArray *titlesArray;

@property (nonatomic, assign) BOOL isFinal;
@property (nonatomic, assign) BOOL isSetupUI;
@property (nonatomic, assign) BOOL firstGameIsFinal;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topDetailView_top_ct;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topDetailView_Height_ct;

@end
@implementation CfipyHTMatchDetailViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"FaCaiMatchDetail");
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initData];
//    [self setupUI];
    
    self.feedLoaded = YES;
    self.summaryLoaded = YES;
    self.isSetupUI = NO;
    self.firstGameIsFinal = NO;
    
    [self.view showLoadingView];
    
    if (isAppInView) {///为了view
        self.topDetailView_Height_ct.constant = 0.1;
        self.topDetailView.hidden = YES;
        [self.view layoutIfNeeded];
    }
    
    [self loadData];
    
    [FIRAnalytics logEventWithName:@"IOS_Match_Detail"
                        parameters:@{
                                     kFIRParameterItemID:[NSString stringWithFormat:@"id:%@-%@-%@", self.matchModel.awayName,self.matchModel.homeName,self.matchModel.gamedate],
                                     kFIRParameterItemName:@"比赛详情",
                                     kFIRParameterContentType:@"match-detail"
                                     }];
}

- (void)viewWillAppear:(BOOL)animated{
   
    if (self.player && self.isPlaying) {
        self.isPlaying = NO;
        [self.player playVideo];
    }
    LMBrightnessViewShared.isStartPlay = self.isStartPlay;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopTimer];
    
    // push出下一级页面时候暂停
    if (self.player && !self.player.isPauseByUser) {
        self.isPlaying = YES;
        [self.player pauseVideo];
    }
    
    LMBrightnessViewShared.isStartPlay = NO;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"CfipyHTMatchDetailViewController viewDidAppear");
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"CfipyHTMatchDetailViewController viewDidDisappear");
    [IQKeyboardManager sharedManager].enable = YES;
}

#pragma mark - 屏幕旋转
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self remakePlayerFatherViewPositionInPortrait];
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self remakePlayerFatherViewPositionInLandscape];
    }
}


- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass(self.class));
    [self destoryPlayer];
    [TuTuosHTUserManager manager].matchSummaryModel = nil;
}

-(void)remakePlayerFatherViewPositionInPortrait{
    
//     [self.playerFatherView mas_remakeConstraints:<#^(MASConstraintMaker *make)block#>]
    [self.playerContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.leading.trailing.mas_equalTo(self.view);
        // 这里宽高比16：9,可自定义宽高比
//        make.height.mas_equalTo(self.view.mas_width).multipliedBy(9.0f/16.0f);
        make.height.mas_equalTo(200);
    }];
}


-(void)remakePlayerFatherViewPositionInLandscape{
    
    [self.playerContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(0);
//                make.left.right.mas_equalTo(self.view);
//            make.height.mas_equalTo(self.view);
        
         make.top.leading.trailing.bottom.equalTo(self.view);
    }];
    
    [self.playerContentView updateConstraintsIfNeeded];
    [self.playerContentView layoutIfNeeded];
    
    self.playerContentView.frame = self.view.bounds;
//    NSLog(@"self.playerFatherView.frame.size.height:%f",self.playerContentView.frame.size.height);
//    NSLog(@"self.playerFatherView.frame.size.width:%f",self.playerContentView.frame.size.width);
//
//    NSLog(@"self.view.frame.size.height:%f",self.view.frame.size.height);
//    NSLog(@"self.view.frame.size.width:%f",self.view.frame.size.width);
}


#pragma mark - private
- (void)setUpPlayerView:(BlysaLMPlayerModel *) model {
            
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startPlay)];
    self.topDetailView.userInteractionEnabled = YES;
    [self.topDetailView addGestureRecognizer:tapGes];
    

    BlysaLMVideoPlayer *player = [BlysaLMVideoPlayer videoPlayerWithView:self.playerContentView delegate:self playerModel:model];
    self.player = player;
}

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
//    [self.view showLoadingView];
    
    [self.awayTeamName setFont:[UIFont boldSystemFontOfSize:18]];
    [self.homeTeamName setFont:[UIFont boldSystemFontOfSize:18]];
    [self.statusLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.homeTeamPtsLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.awayTeamPtsLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.startTimeLable setFont:[UIFont boldSystemFontOfSize:20]];

    self.backPlayView.hidden = YES;
    self.gameTimeLabel.hidden = YES;
//============================

//    self.topDetailView.hidden = YES;
    self.startPlayImageView.hidden = YES;
    self.startTimeLable.hidden = YES;
    [self.view addSubview:self.playerContentView];
    [self remakePlayerFatherViewPositionInPortrait];
    self.playerContentView.hidden = YES;
    
    
    //讚部分
    self.likeIndicatorView = [[UUaksHTIndicatorView alloc] init];
    [self.likeContentView addSubview:self.likeIndicatorView];
    [self.likeIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2.4);
        make.width.mas_equalTo(self.likeContentView);
        make.bottom.mas_equalTo(self.likeContentView.mas_bottom);
    }];
    
   BOOL awayLike = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"USER_LIKED_%@_%@", self.matchModel.game_id,@"away"]];
    BOOL homeLike = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"USER_LIKED_%@_%@", self.matchModel.game_id,@"home"]];
    
    if (awayLike) {
        [self.leftLikeBtn setImage:[UIImage imageNamed:@"icon_left_like"] forState:(UIControlStateNormal)];
    }else if (homeLike){
        [self.rightLikeBtn setImage:[UIImage imageNamed:@"icon_right_like"] forState:(UIControlStateNormal)];
    }
    self.leftLikeLabel.text = [NSString stringWithFormat:@"客   %@", self.matchModel.awayTeamLike];
    self.rightLikeLabel.text = [NSString stringWithFormat:@"%@   主", self.matchModel.homeTeamLike];
}
- (IBAction)rightLikeBtnClick:(id)sender {//主隊
    
    BOOL awayLike = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"USER_LIKED_%@_%@", self.matchModel.game_id,@"away"]];
    BOOL homeLike = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"USER_LIKED_%@_%@", self.matchModel.game_id,@"home"]];
    if (awayLike || homeLike) {
        [kWindow showToast:@"已經點讚了"];
        return;
    }
    //[self.likeIndicatorView updateView:0 rightValue:5];
    [MMoogHTMatchSummaryRequest requestLikeMatchTeamWithGameId:self.matchModel.game_id type:@"1" successBlock:^(BByasHTLikeTeamModel *m) {
        if (!m) {
           return;
        }
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:[NSString stringWithFormat:@"USER_LIKED_%@_%@", self.matchModel.game_id,@"home"]];
        if (self.likeIndicatorView) {
            [self.likeIndicatorView updateView:[m.awayTeamLike intValue] rightValue:[m.homeTeamLike intValue]];
        }
        self.leftLikeLabel.text = [NSString stringWithFormat:@"客   %@", m.awayTeamLike];
        self.rightLikeLabel.text = [NSString stringWithFormat:@"主   %@", m.homeTeamLike];
        [self.rightLikeBtn setImage:[UIImage imageNamed:@"icon_right_like"] forState:(UIControlStateNormal)];
        
    } errorBlock:^(WSKggBJError *error) {
        [kWindow showToast:@"請求出錯"];
    }];
    
}
- (IBAction)leftLikeBtnCliek:(id)sender {
    
//    if (sender) {
//        [self startPlay];
//        return;
//    }
    BOOL awayLike = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"USER_LIKED_%@_%@", self.matchModel.game_id,@"away"]];
    BOOL homeLike = [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"USER_LIKED_%@_%@", self.matchModel.game_id,@"home"]];
    if (awayLike || homeLike) {
         [kWindow showToast:@"已經點讚了"];
        return;
    }
    [MMoogHTMatchSummaryRequest requestLikeMatchTeamWithGameId:self.matchModel.game_id type:@"2" successBlock:^(BByasHTLikeTeamModel *m) {
        if (!m) {
            return;
        }
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:[NSString stringWithFormat:@"USER_LIKED_%@_%@", self.matchModel.game_id,@"away"]];
        if (self.likeIndicatorView) {
            [self.likeIndicatorView updateView:[m.awayTeamLike intValue] rightValue:[m.homeTeamLike intValue]];
        }
        self.leftLikeLabel.text = [NSString stringWithFormat:@"客   %@", m.awayTeamLike];
        self.rightLikeLabel.text = [NSString stringWithFormat:@"主   %@", m.homeTeamLike];
        
        [self.leftLikeBtn setImage:[UIImage imageNamed:@"icon_left_like"] forState:(UIControlStateNormal)];
     
        
    } errorBlock:^(WSKggBJError *error) {
        [kWindow showToast:@"請求出錯"];
    }];
}

- (void)startPlay {
//    @"http://www.bballman.com/category/live"
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.bballman.com/category/live"]];
//    safariVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [self presentViewController:safariVC animated:YES completion:^{
//
//    }];
    
    NSString *token = @"";
    if (![TuTuosHTUserManager tao_isUserLogin]) {
        [kWindow showToast:@"請先登入帳號"];
        [TuTuosHTUserManager tao_doUserLogin];
        return;
    }
    token = [TuTuosHTUserManager tao_userToken];
    
    NSString *webUrl = [NSString stringWithFormat:@"http://app.ballgametime.com/api/nbaschedule.php?token=%@&game_id=%@",token,self.matchModel.game_id];

    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrl] options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrl]];
    }

    
    //========由于版权的问题，不能播放了==============//
//    if (self.player) {
//        self.playerContentView.hidden = NO;
//        [self.player autoPlayTheVideo];
//        self.topDetailView.hidden = YES;
//    }
    
    
//    BlysaLMPlayerModel *model = [[BlysaLMPlayerModel alloc] init];
//    model.videoUrls = @[@"https://demo-videos.qnsdk.com/movies/Sunset.mp4"];
//    [self setUpPlayerView:model];
//
//    if (self.player) {
//        self.playerContentView.hidden = NO;
//        [self.player autoPlayTheVideo];
//        self.topDetailView.hidden = YES;
//    }
}

-(void)destoryPlayer{
    if (self.player) {
        [self.player destroyVideo];
    }
 
}

- (UIView *)playerContentView {
    if (!_playerContentView) {
        _playerContentView = [[UIView alloc] init];
        
        _playerContentView.backgroundColor = [UIColor grayColor];
    }
    return _playerContentView;
}

- (void)initData {
    
    if ([self.matchModel.scheduleStatus isEqualToString:@"Final"]) {
        self.titlesArray = @[@" 嗨賴 ",@" 聊球 ", @" 對陣 ", @"數據統計", @"文字直播"];
        self.isFinal = YES;
        self.firstGameIsFinal = YES;
    }else{
        self.titlesArray = @[@" 聊球 ", @" 對陣 ", @"數據統計", @"文字直播"];
        self.isFinal = NO;
        self.firstGameIsFinal = NO;
    }
    
    for (NSInteger i = 0; i < self.titlesArray.count; i++) {
        [self.loadedFlagArray addObject:@(NO)];
        [self.loadedControllersArray addObject:@(NO)];
    }
    
    if ([self.matchModel.scheduleStatus isEqualToString:@"InProgress"]) {
        
        self.startPlayImageView.hidden = NO;
        [MMoogHTMatchSummaryRequest requestLivePostWithGameId:self.matchModel.game_id successBlock:^(KSasxHTMacthLivePostModel *livePost) {
            if (livePost) {
                
                self.livePost = livePost;
                BlysaLMPlayerModel *model = [[BlysaLMPlayerModel alloc] init];
                //    model.videoURL = [NSURL URLWithString:@"http://9890.vod.myqcloud.com/9890_4e292f9a3dd011e6b4078980237cc3d3.f30.mp4"];
                //    model.seekTime = 20;
                //    model.viewTime = 200;
                //
                model.videoUrls = self.livePost.live_url;
                [self setUpPlayerView:model];
            }
            
        } errorBlock:^(WSKggBJError *error) {
            
         
        }];
    }
    
//    =======tests========
//    self.startPlayImageView.hidden = NO;
//    BlysaLMPlayerModel *model = [[BlysaLMPlayerModel alloc] init];
//    model.videoUrls = @[@"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8", @"http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8"
//    ,@"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8"];
//   [self setUpPlayerView:model];
//    =======tests========
   
}

- (void)loadDataForTimer
{
    if (self.isFinal) {
        [self stopTimer];
        return;
    }
    [self loadData];
}


- (void)loadData {
    if (!self.feedLoaded || !self.summaryLoaded) {
        return;
    }
    self.feedLoaded = NO;
    self.summaryLoaded = NO;
    self.error = nil;
    [FFlaliHTMatchLiveFeedRequest taorequestLiveFeedWithGameId:self.matchModel.game_id successBlock:^(NSArray<FFlaliHTMatchLiveFeedModel *> *feedList) {
        self.liveFeedList = feedList;//[NSArray arrayWithObject:[feedList lastObject]];
        self.feedLoaded = YES;
        [self refreshUI];
    } errorBlock:^(WSKggBJError *error) {
        self.error = error;
        self.feedLoaded = YES;
        [self refreshUI];
    }];
    [MMoogHTMatchSummaryRequest taorequestSummaryWithGameId:self.matchModel.game_id successBlock:^(KSasxHTMatchSummaryModel *summaryModel, BByasHTMatchCompareModel *compareModel) {
       //summaryModel.scheduleStatus = @"InProgress";
        self.matchSummaryModel = summaryModel;
        self.matchCompareModel = compareModel;
        self.summaryLoaded = YES;
        [self refreshUI];
        
        [self.imVc setData:self.matchModel summary:self.matchSummaryModel];
        
        [TuTuosHTUserManager manager].matchSummaryModel = self.matchSummaryModel;
        
    } errorBlock:^(WSKggBJError *error) {
        self.error = error;
        self.summaryLoaded = YES;
        [self refreshUI];
    }];
}
- (void)refreshUI {
    
    if (!self.isSetupUI && self.matchSummaryModel) {
        self.matchModel.scheduleStatus = self.matchSummaryModel.scheduleStatus;
        [self initData];
        [self setupUI];
        self.isSetupUI = YES;
    }
    
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
    
//    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"live_player_bg.png"]];
//    [self.topDetailView setBackgroundColor:bgColor];
//    self.homeTeamLogo.hidden = YES;
//    self.awayTeamLogo.hidden = YES;
    self.homeTeamLogo.hidden = NO;
     self.awayTeamLogo.hidden = NO;
    if ([self.matchSummaryModel.homeLogo hasSuffix:@"svg"]) {
        [self.awayTeamLogo svg_setImageWithURL:[NSURL URLWithString:self.matchSummaryModel.homeLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }else{
        [self.awayTeamLogo sd_setImageWithURL:[NSURL URLWithString:self.matchSummaryModel.homeLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }
    self.homeTeamPtsLabel.text = self.matchSummaryModel.away_pts;
   
    if ([self.matchSummaryModel.awayLogo hasSuffix:@"svg"]) {
        [self.homeTeamLogo svg_setImageWithURL:[NSURL URLWithString:self.matchSummaryModel.awayLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }else{
        [self.homeTeamLogo sd_setImageWithURL:[NSURL URLWithString:self.matchSummaryModel.awayLogo] placeholderImage:HT_DEFAULT_TEAM_LOGO];
    }
    
//    self.awayTeamName.text = self.matchSummaryModel.awayName;
//    self.homeTeamName.text = self.matchSummaryModel.homeName;
    
    self.awayTeamName.text = self.matchSummaryModel.homeName;
        self.homeTeamName.text = self.matchSummaryModel.awayName;
    
    self.awayTeamPtsLabel.text = self.matchSummaryModel.home_pts;
//    self.timeLabel.hidden = YES;
//    if (self.matchSummaryModel.game_status == 1) {
//        self.statusLabel.text = @"已結束";
//        [self stopTimer];
//    } else
    
    if ([self.matchSummaryModel.scheduleStatus isEqualToString:@"Final"]) {
        
        self.isFinal = YES;
        self.statusLabel.text = @"已結束";
        self.statusLabel.hidden = YES;
        
        self.gameTimeLabel.hidden = NO;
        self.gameTimeLabel.text = [NSString stringWithFormat:@"%@ %@",self.matchModel.date,self.matchModel.gametime];
        
        if ([self showPlayback]) {//比赛结束6小时候显示
            self.backPlayView.hidden = NO;
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startPlay)];
            self.backPlayView.userInteractionEnabled = YES;
            [self.backPlayView addGestureRecognizer:tapGes];
            
        }else{
            self.backPlayView.hidden = YES;
        }
        
        [self stopTimer];
    } else if ([self.matchSummaryModel.scheduleStatus isEqualToString:@"InProgress"]) {
        self.startPlayImageView.hidden = NO;
        self.statusLabel.text = [NSString stringWithFormat:@"第%@節\n%@", self.matchSummaryModel.quarter, self.matchSummaryModel.time];
        if ([self.matchSummaryModel.quarter isEqualToString:@"OT"]) {
            self.statusLabel.text = self.matchSummaryModel.quarter;
        }
//        self.timeLabel.text = self.matchSummaryModel.time;
        [self startTimer];
    } else if ([self.matchSummaryModel.scheduleStatus isEqualToString:@"Canceled"]) {
        self.statusLabel.text = @"已取消";
    } else  {
        self.statusLabel.text = @"未開始";
        self.startTimeLable.hidden = NO;
        self.awayTeamPtsLabel.hidden = YES;
        self.homeTeamPtsLabel.hidden = YES;
        self.startTimeLable.text = self.matchModel.gametime;
    }
    [self segmentedValueChangedHandle:self.currentIndex];
    if (self.loadedBlock) {
        self.loadedBlock();
    }
    
    //设置点赞部分数据
    if (self.likeIndicatorView) {
        [self.likeIndicatorView updateView:[self.matchSummaryModel.awayTeamLike intValue] rightValue:[self.matchSummaryModel.homeTeamLike intValue]];
    }
    self.leftLikeLabel.text = [NSString stringWithFormat:@"客   %@", self.matchSummaryModel.awayTeamLike];
    self.rightLikeLabel.text = [NSString stringWithFormat:@"主   %@", self.matchSummaryModel.homeTeamLike];
}
- (void)startTimer {
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                  target:self
                                                selector:@selector(loadDataForTimer)
                                                userInfo:nil
                                                 repeats:YES];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

//- (void)tao_handlePopActionMySelf{
//    NSLog(@"tao_handlePopActionMySelf");
//}
//
//- (BOOL)tao_shouldHandlePopActionMySelf{
//    NSLog(@"tao_shouldHandlePopActionMySelf");
//    return YES;
//}

#pragma mark - BJNavigationDelegate
- (void)tao_handleNavBack{
     [self destoryPlayer];
    [self viewWillDisappear:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSInteger page = offset.x / SCREEN_WIDTH;
    self.currentIndex = page;
    [self loadChildViewControllerByIndex:page];
    [self.segmentControl setSelectedSegmentIndex:page animated:YES];
}

#pragma mark - LMVideoPlayerDelegate
/** 返回按钮被点击 */
- (void)playerBackButtonClick {

    [self destoryPlayer];
}

/** 控制层封面点击事件的回调 */
- (void)controlViewTapAction {
    if (_player) {
        [self.player autoPlayTheVideo];
        self.isStartPlay = YES;
    }
}


#pragma mark -- HMSegmentedControl Action
- (void)segmentedValueChangedHandle:(NSInteger)index {
    self.currentIndex = index;
    [self loadChildViewControllerByIndex:index];
    [self.containerView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
}
- (void)loadChildViewControllerByIndex:(NSInteger)index {
    
    //是否显示嗨赖
     if (self.firstGameIsFinal) {
         
         if ([self.loadedFlagArray[index] boolValue]) {
             if (index == 0) {

//                 BlysaHTMatchVideoLiveViewController *detailVc =  self.loadedControllersArray[index];//[BlysaHTMatchVideoLiveViewController taoviewController];
//                 detailVc.game_id = self.matchModel.game_id;
                 TuTuosHTHighLightsViewController *hlVc =  self.loadedControllersArray[index];
                 [hlVc refreshDataWithGameId:self.matchModel.game_id mMatchSummaryModel:self.matchSummaryModel mCompareModel:self.matchCompareModel];
                
             } else if (index == 4) {//文字直播
                 KSasxHTMatchWordLiveViewController *wordVc = self.loadedControllersArray[index];
                [wordVc taorefreshWithLiveFeedList:self.liveFeedList summary:self.matchSummaryModel gameId:self.matchModel.game_id];
                
                 
             }else if (index == 2) {//對陣
                 TuTuosHTMatchCompareViewController *compareVc = self.loadedControllersArray[index];
                 [compareVc taorefreshWithMatchSummaryModel:self.matchSummaryModel matchCompareModel:self.matchCompareModel liveFeedModel:self.liveFeedList matchModel:self.matchModel];
             }else if (index == 1) {//聊天
                 WSKggHTIMViewController *imVc = self.loadedControllersArray[index];
                 [imVc setData:self.matchModel summary:self.matchSummaryModel];
             } else {
                 FFlaliHTMatchDashboardViewController *dashbdVc = self.loadedControllersArray[index];
                 [dashbdVc taorefreshWithMatchCompareModel:self.matchCompareModel];
             }
             return;
         }
         kWeakSelf
         UIViewController *vc;
         if (index == 0) {


             //视频直播
             TuTuosHTHighLightsViewController *hlVc = [TuTuosHTHighLightsViewController taoviewController];
             [hlVc refreshDataWithGameId:self.matchModel.game_id mMatchSummaryModel:self.matchSummaryModel mCompareModel:self.matchCompareModel];
             vc = hlVc;

         } else
             if (index == 4) {
             
             KSasxHTMatchWordLiveViewController *wordVc = [KSasxHTMatchWordLiveViewController taoviewController];
                 
            [wordVc taorefreshWithLiveFeedList:self.liveFeedList summary:self.matchSummaryModel gameId:self.matchModel.game_id];
                 
             wordVc.onTableHeaderRefreshBlock = ^{
                 [weakSelf loadData];
             };
             vc = wordVc;
             
         }else if (index == 2) {
             TuTuosHTMatchCompareViewController *compareVc = [TuTuosHTMatchCompareViewController taoviewController];
             
             [compareVc taorefreshWithMatchSummaryModel:self.matchSummaryModel matchCompareModel:self.matchCompareModel liveFeedModel:self.liveFeedList  matchModel:self.matchModel];
            
             compareVc.onTableHeaderRefreshBlock = ^{
                 [weakSelf loadData];
             };
             vc = compareVc;
             
         }else if (index == 1) {
             self.imVc = [WSKggHTIMViewController taoviewController];
             [self.imVc setData:self.matchModel summary:self.matchSummaryModel];
             vc = self.imVc;
         } else {
             FFlaliHTMatchDashboardViewController *dashboardVc = [FFlaliHTMatchDashboardViewController taoviewController];
             dashboardVc.matchModel = self.matchModel;
             [dashboardVc taorefreshWithMatchCompareModel:self.matchCompareModel];
             vc = dashboardVc;
         }
         [self addChildViewController:vc];
         [self.containerView addSubview:vc.view];
         [self.loadedFlagArray replaceObjectAtIndex:index withObject:@(YES)];
         [self.loadedControllersArray replaceObjectAtIndex:index withObject:vc];
         [self setChildViewFrame:vc.view byIndex:index];
         
         return;
     }
    
    //=====   未结束或者未开始--没有嗨赖
    if ([self.loadedFlagArray[index] boolValue]) {
        if (index == 3) {//文字直播
            KSasxHTMatchWordLiveViewController *wordVc = self.loadedControllersArray[index];
           [wordVc taorefreshWithLiveFeedList:self.liveFeedList summary:self.matchSummaryModel gameId:self.matchModel.game_id];
           
        }else if (index == 1) {//對陣
            TuTuosHTMatchCompareViewController *compareVc = self.loadedControllersArray[index];
            [compareVc taorefreshWithMatchSummaryModel:self.matchSummaryModel matchCompareModel:self.matchCompareModel liveFeedModel:self.liveFeedList matchModel:self.matchModel];
        }else if (index == 0) {//聊起
            WSKggHTIMViewController *imVc = self.loadedControllersArray[index];
            [imVc setData:self.matchModel summary:self.matchSummaryModel];
        } else {
            FFlaliHTMatchDashboardViewController *dashbdVc = self.loadedControllersArray[index];
            [dashbdVc taorefreshWithMatchCompareModel:self.matchCompareModel];
        }
        return;
    }
    kWeakSelf
    UIViewController *vc;
 
    if (index == 3) {
        
        KSasxHTMatchWordLiveViewController *wordVc = [KSasxHTMatchWordLiveViewController taoviewController];
        [wordVc taorefreshWithLiveFeedList:self.liveFeedList summary:self.matchSummaryModel gameId:self.matchModel.game_id];
        wordVc.onTableHeaderRefreshBlock = ^{
            [weakSelf loadData];
        };
        vc = wordVc;
        
    }else if (index == 1) {
        TuTuosHTMatchCompareViewController *compareVc = [TuTuosHTMatchCompareViewController taoviewController];
        
        [compareVc taorefreshWithMatchSummaryModel:self.matchSummaryModel matchCompareModel:self.matchCompareModel liveFeedModel:self.liveFeedList  matchModel:self.matchModel];
       
        compareVc.onTableHeaderRefreshBlock = ^{
            [weakSelf loadData];
        };
        vc = compareVc;
        
    }else if (index == 0) {
        self.imVc = [WSKggHTIMViewController taoviewController];
        [self.imVc setData:self.matchModel summary:self.matchSummaryModel];
        vc = self.imVc;
    } else {
        FFlaliHTMatchDashboardViewController *dashboardVc = [FFlaliHTMatchDashboardViewController taoviewController];
        dashboardVc.matchModel = self.matchModel;
        [dashboardVc taorefreshWithMatchCompareModel:self.matchCompareModel];
        vc = dashboardVc;
    }
    [self addChildViewController:vc];
    [self.containerView addSubview:vc.view];
    [self.loadedFlagArray replaceObjectAtIndex:index withObject:@(YES)];
    [self.loadedControllersArray replaceObjectAtIndex:index withObject:vc];
    [self setChildViewFrame:vc.view byIndex:index];
    
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

        _segmentControl = [[HMSegmentedControl alloc] initWithSectionTitles:self.titlesArray];
        _segmentControl.selectionIndicatorColor = appBaseColor;
        _segmentControl.selectionIndicatorHeight = 3.0f;
        _segmentControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -8, 0, -18);
        _segmentControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"666666"]};
        _segmentControl.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium],NSForegroundColorAttributeName:appBaseColor};
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        kWeakSelf
        _segmentControl.indexChangeBlock = ^(NSUInteger index){
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
        _containerView.contentSize = CGSizeMake(SCREEN_WIDTH * self.titlesArray.count, SCREEN_HEIGHT - 64 - SCREEN_HEIGHT - 1);
        _containerView.bounces = NO;
    }
    return _containerView;
}

-(BOOL)showPlayback
{
    NSString *timeStr = [NSString stringWithFormat:@"%@ %@",self.matchModel.gamedate, [self.matchModel.time uppercaseString]];
    NSString *timeStamp = [UUaksConfigCoreUtil getTimeStrWithString: timeStr];
    
    double now_timestamp = [[UUaksConfigCoreUtil getTimeStamp] doubleValue];
    double game_timestamp = [timeStamp doubleValue];
    if (now_timestamp - game_timestamp > 6 * 60 * 60 * 1000) { //游戏未开始
        return YES;
    }
    return NO;
}
@end
