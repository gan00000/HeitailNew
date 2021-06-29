//
//  BByasYSPlayerControl.m
//  ijkplayerDemo
//
//  Created by 张延深 on 2020/4/13.
//  Copyright © 2020 张延深. All rights reserved.
//

#import "BByasYSPlayerControl.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MMoogYSNetworkInfoTool.h"
#import "UUaksYSBatteryTool.h"
#import "CfipyYSCarrierTool.h"
#import "KSasxYSScreenBrightnessTool.h"
#import "NSNiceYSVolumeTool.h"
//#import "SDWeakProxy.h"
#import "BlysaBJUtility.h"
#import "UIColor+FFlaliHex.h"
#import <Masonry/Masonry.h>

#define NAV_BAR_HEIGHT 50
#define TOOL_BAR_HEIGHT 60

typedef NS_ENUM(NSUInteger, YSPanDirection) {
    YSPanDirectionUnknown, // 未知
    YSPanDirectionHorizontal, // 水平
    YSPanDirectionVertical // 垂直
};

@interface BByasYSPlayerControl () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *navBar;
@property (weak, nonatomic) IBOutlet UIView *toolBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBarTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarTrailingConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playBtnLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fullScreenTralingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payTimeLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *volumeViewTopConstraint;

/*
 status bar
 */
@property (weak, nonatomic) IBOutlet UIView *statusBar;
@property (weak, nonatomic) IBOutlet UILabel *networkInfoLbl; // 网络信息
@property (weak, nonatomic) IBOutlet UILabel *carrierLbl; // 运营商
@property (weak, nonatomic) IBOutlet UILabel *timeLbl; // 时间
@property (weak, nonatomic) IBOutlet UILabel *batteryStateLbl; // 电池状态
@property (weak, nonatomic) IBOutlet UILabel *batteryLevelLbl; // 电量

/*
 自定义音量和亮度view
 */
@property (weak, nonatomic) IBOutlet UIView *volumeView;
@property (weak, nonatomic) IBOutlet UIProgressView *volumeProgressView;
@property (weak, nonatomic) IBOutlet UILabel *volumeTipLbl;

/*
 视频操作相关按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLbl; //播放的时间
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLbl;//视频时间长度

/** 缓冲进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *bufferProgressView;


@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@property (assign, nonatomic, getter=isHideBar) BOOL hideBar;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *timeTimer; // 时间计时器

@property (assign, nonatomic) YSPanDirection direction;
@property (nonatomic, assign) BOOL isVolume;/*!*是否在调节音量*/

@property (strong, nonatomic) UUaksYSBatteryTool *batteryTool;
@property (strong, nonatomic) NSNiceYSVolumeTool *volumeTool;

@property (weak, nonatomic) IBOutlet UIButton *rePlayBtn;
@property (weak, nonatomic) IBOutlet UIButton *rePauseBtn;

@property (weak, nonatomic) IBOutlet UIView *slideContentView;
@property (weak, nonatomic) IBOutlet UIImageView *slideDirectionImageView;
@property (weak, nonatomic) IBOutlet UILabel *slideTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *slideProgressView;

@property (assign, nonatomic) NSTimeInterval totalTime;
@property (assign, nonatomic) NSTimeInterval currentSlideTime;

//=========
/** 单击 */
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
/** 双击 */
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
/** 滑动 */
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@property (weak, nonatomic) IBOutlet UIButton *playerBackBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerBackBtnConstraint;

@end

@implementation BByasYSPlayerControl

@synthesize delegate = _delegate;
@synthesize fullScreen = _fullScreen;
@synthesize playing = _playing;
@synthesize prepareToPlay = _prepareToPlay;
@synthesize portraitFullScreen = _portraitFullScreen;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initViewStatus];
}


- (void)initViewStatus
{
    self.direction = YSPanDirectionUnknown;
    self.hideBar = NO;
    self.clipsToBounds = YES;
    // 音量、亮度view
    self.volumeView.layer.cornerRadius = 5;
    
    //播放进度条
    self.progressSlider.continuous = NO;
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:(UIControlStateNormal)];
    
    self.bufferProgressView.progressTintColor = [UIColor grayColor];
    self.bufferProgressView.trackTintColor = [UIColor whiteColor];
    self.bufferProgressView.progress = 0;
    
    self.progressSlider.maximumTrackTintColor = [UIColor clearColor];//[UIColor whiteColor];
    self.progressSlider.minimumTrackTintColor = appBaseColor;//[UIColor whiteColor];//[UIColor
    
    self.rePlayBtn.hidden = YES;
    self.rePauseBtn.hidden = YES;
    self.playerBackBtn.hidden = YES;
    // 添加触摸手势
    [self addTapGesture];
    // 添加滑动手势
//    [self addPanGesture];
    // 开启timer
//    [self resetTimer];
    // 获取运营商
//    [self loadCarrier];
    // 获取网络信息
//    [self loadNetworkInfo];
    // 获取电池信息
//    [self loadBatteryInfo];
    // 开启获取系统时间timer
//    [self startTimeTimer];
    // 添加MPVolumeView
    [self addMPVolumeView];
    [self initSlideView];
}

-(void) initSlideView
{
    self.slideContentView.hidden = YES;
    self.slideContentView.layer.cornerRadius = 10;
    self.slideTimeLabel.textColor = appBaseColor;
    self.slideProgressView.progressTintColor = appBaseColor;
    self.slideProgressView.trackTintColor = [UIColor whiteColor];
    self.slideProgressView.progress = 0;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(self.navBar.frame, point) || CGRectContainsPoint(self.toolBar.frame, point)) {
        return NO;
    }
    return YES;
}

#pragma mark - YSPlayerControlProtocol

- (void)setPlayTime:(NSTimeInterval)playTime playableDuration:(NSTimeInterval)playableTime totalTime:(NSTimeInterval)totalTime {
//    self.playTimeLbl.text = [self formatTime:playTime];
//    self.totalTimeLbl.text = [self formatTime:totalTime];
    
    self.totalTime = totalTime;
    self.progressSlider.value = playTime / totalTime;
    
    self.playTimeLbl.text = [NSString stringWithFormat:@"%@/%@",[self formatTime:playTime],[self formatTime:totalTime]];
    
    double loadProgress = playableTime / totalTime;
    
    self.bufferProgressView.progress = loadProgress;
    
}

- (void)playbackComplete {
    self.progressSlider.value = 0.0;
    self.bufferProgressView.progress = 0;
    self.playTimeLbl.text = @"00:00";
    self.rePlayBtn.hidden = NO;
    self.rePauseBtn.hidden = YES;
    self.hideBar = NO;
    
    
    if (self.portraitFullScreen) {
        self.toolBarBottomConstraint.constant = self.hideBar ? -TOOL_BAR_HEIGHT : 20;
        if ([BlysaBJUtility isIPhoneXSeries]) {
            self.navBarTopConstraint.constant = self.hideBar ? -NAV_BAR_HEIGHT : 44;
        }else{
            self.navBarTopConstraint.constant = self.hideBar ? -NAV_BAR_HEIGHT : 0;
        }
    }else{
        self.toolBarBottomConstraint.constant = self.hideBar ? -TOOL_BAR_HEIGHT : 0;
        self.navBarTopConstraint.constant = self.hideBar ? -NAV_BAR_HEIGHT : 0;
    }
   
    [self layoutIfNeeded];
    
}

- (void)playbackShutDown{
    [self invalidTimer];
    [self invalidTimeTimer];
    [self playbackComplete];
    [self removeFromSuperview];
    
}

- (void)playerReparedToPlayDidChange
{
    [self resetTimer];
}

#pragma mark - Event response

- (void)handleSingleTapGesture:(UITapGestureRecognizer *)tap {
    NSLog(@"ysplayer handleSingleTapGesture");
    [self toggleBar];
}

- (void)handleDoubleTapGesture:(UITapGestureRecognizer *)tap {
    NSLog(@"ysplayer handleDoubleTapGesture");
    if ([self.delegate respondsToSelector:@selector(playOrPause)]) {
        [self.delegate playOrPause];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan {
    NSLog(@"ysplayer handlePanGesture");
    // 根据上次和本次移动的位置，算出一个速率的point
    //这个很关键,这个速率直接决定了平移手势的快慢
    CGPoint veloctyPoint = [pan velocityInView:pan.view];
    CGPoint translation = [pan translationInView:pan.view];

    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{ // 开始移动
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) { // 水平移动
                self.direction = YSPanDirectionHorizontal;
                // 让timer失效
                [self invalidTimer];
                // 暂停播放
                if ([self.delegate respondsToSelector:@selector(progressChangeStart)]) {
                    [self.delegate progressChangeStart];
                }
                self.slideContentView.hidden = NO;
                self.slideProgressView.progress = self.progressSlider.value;
                
            } else if (x < y) { // 垂直移动
                // 获取当前页面手指触摸的点
                CGPoint locationPoint = [pan locationInView:pan.view];
                // 音量和亮度
                self.direction = YSPanDirectionVertical;
                // 显示volumeView
                self.volumeView.hidden = NO;
                // 判断移动的点在屏幕的哪个位置
                if (locationPoint.x <= self.frame.size.width / 2.0) {//以屏幕的1/2位分界线
                    //亮度,调节亮度
                    self.isVolume = NO;
                    // 初始化屏幕亮度
                    [self initScreenBrightness];
                } else {
                    //音量.调节音量
                    self.isVolume = YES;
                    // 初始化系统音量
                    [self initSystemVolume];
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{ // 正在移动
            switch (self.direction){//通过手势变量来判断是什么操作
                case YSPanDirectionVertical: // 垂直
                {
                    CGFloat scale = translation.y / self.bounds.size.height;
                    if (self.isVolume) {
                        [self changeVolume:scale];
                    } else {
                        [self changeBrightness:scale];
                    }
                    break;
                }
                case YSPanDirectionHorizontal: // 水平
                {
                    CGFloat scale = translation.x / self.bounds.size.width;
                    self.progressSlider.value += scale;
                    if (self.progressSlider.value > 1.0) {
                        self.progressSlider.value = 1.0;
                    }
                    if (self.progressSlider.value < 0.0) {
                        self.progressSlider.value = 0.0;
                    }
                    if ([self.delegate respondsToSelector:@selector(didChangeProgress:)]) {
                        [self.delegate didChangeProgress:self.progressSlider.value];
                    }
                    [self changeSlideProgressView:scale progress:self.progressSlider.value];
                    
                    break;
                }
                default:
                {
                    
                }
                    break;
            }
            break;

        }
        case UIGestureRecognizerStateEnded: { // 移动停止
            switch (self.direction) {
                case YSPanDirectionVertical: // 垂直
                {
                    self.isVolume = NO;
                    // 隐藏volumeView
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [UIView animateWithDuration:0.5 animations:^{
                            self.volumeView.alpha = 0.0;
                        } completion:^(BOOL finished) {
                            self.volumeView.hidden = YES;
                            self.volumeView.alpha = 1.0;
                        }];
//                    });
                    break;
                }
                case YSPanDirectionHorizontal: //水平
                {
                    // 重新开启timer
                    [self resetTimer];
                    // 开始播放
                    if ([self.delegate respondsToSelector:@selector(progressChangeEnd)]) {
                        [self.delegate progressChangeEnd];
                    }
                    self.slideContentView.hidden = YES;
                    break;
                }
                default:
                {
                    
                }
                    break;
            }
        }
        default:
        {
            
        }
            break;
    }
    // 清空位移数据，避免拖拽事件的位移叠加
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (IBAction)doneBtnClick:(UIButton *)sender {//返回

    [self resetTimer];
    if ([self.delegate respondsToSelector:@selector(fullScreen)]) {
        [self.delegate fullScreen];
        [self toggleBarImmediately:YES];
    }
    
}

- (IBAction)playSpeedChanged:(UIButton *)sender {
    [self resetTimer];
    static CGFloat rate = 1.0;
    if ([self.delegate respondsToSelector:@selector(setPlaybackRate:)]) {
        rate += 0.5;
        if (rate > 2.0) {
            rate = 0.5;
        }
        [sender setTitle:[NSString stringWithFormat:@"%.1lfx", rate] forState:UIControlStateNormal];
        [self.delegate setPlaybackRate:rate];
    }
}


- (IBAction)rePlayBtnClick:(id)sender {
    [self playOrPause:sender];
    
    self.rePlayBtn.hidden = YES;
    self.rePauseBtn.hidden = NO;

}

- (IBAction)pauseBtnClick:(id)sender {
    [self playOrPause:sender];
    self.rePlayBtn.hidden = NO;
    self.rePauseBtn.hidden = YES;
}


- (IBAction)playOrPause:(UIButton *)sender {
    [self resetTimer];
    if ([self.delegate respondsToSelector:@selector(playOrPause)]) {
        [self.delegate playOrPause];
    }
}

- (IBAction)fullScreen:(UIButton *)sender {
    [self resetTimer];
    if ([self.delegate respondsToSelector:@selector(fullScreen)]) {
        [self.delegate fullScreen];
        [self toggleBarImmediately:YES];
    }
}

- (IBAction)progressStartChange:(UISlider *)sender {
    [self invalidTimer];
    if ([self.delegate respondsToSelector:@selector(progressChangeStart)]) {
        [self.delegate progressChangeStart];
    }
}

- (IBAction)progressChanged:(UISlider *)sender {
    if ([self.delegate respondsToSelector:@selector(didChangeProgress:)]) {
        [self.delegate didChangeProgress:sender.value];
    }
}

- (IBAction)progressEndChange:(UISlider *)sender {
    [self resetTimer];
    if ([self.delegate respondsToSelector:@selector(progressChangeEnd)]) {
        [self.delegate progressChangeEnd];
    }
}

#pragma mark - Setters/Getters

- (void)setPlaying:(BOOL)playing {
    _playing = playing;
    NSString *img = playing ? @"gurk_player-pause" : @"gurk_player-start";
    [self.playBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    
    if (!playing) {
        self.rePlayBtn.hidden = NO;
        self.rePauseBtn.hidden = YES;
    }else{
        self.rePlayBtn.hidden = YES;
        self.rePauseBtn.hidden = YES;
    }
//    [self toggleBar];
}

- (void)setFullScreen:(BOOL)fullScreen{
    _fullScreen = fullScreen;
//    self.portraitFullScreen = portraitFullScreen;
    
    NSString *img = fullScreen ? @"gurk_player-small-screen" : @"gurk_player-full-screen";
    [self.fullScreenBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
//    self.statusBar.hidden = fullScreen ? NO : YES;
    if (fullScreen) {//全屏
        
        [self addPanGesture];
        if (!self.portraitFullScreen && [BlysaBJUtility isIPhoneXSeries]) {
//            self.playBtnLeadingConstraint.constant = 44;
            self.fullScreenTralingConstraint.constant = 16;
            self.payTimeLeadingConstraint.constant = 44;
            self.playerBackBtnConstraint.constant = 40;
        }
        if (self.portraitFullScreen && [BlysaBJUtility isIPhoneXSeries]){
            self.volumeViewTopConstraint.constant = 50;
            self.playerBackBtnConstraint.constant = 12;
        }
        
        self.playerBackBtn.hidden = NO;
        
    }else
    {//非全屏
        self.playerBackBtn.hidden = YES;
        [self removePanGesture];
        if ([BlysaBJUtility isIPhoneXSeries]) {
//            self.playBtnLeadingConstraint.constant = 8;
            self.fullScreenTralingConstraint.constant = 8;
            self.payTimeLeadingConstraint.constant = 8;
            self.volumeViewTopConstraint.constant = 8;
        }
    }
}

- (void)setPrepareToPlay:(BOOL)prepareToPlay {
    _prepareToPlay = prepareToPlay;
    if (prepareToPlay) {
        [self.activityIndicatorView stopAnimating];
    } else {
        [self.activityIndicatorView startAnimating];
    }
}

- (void)setPortraitFullScreen:(BOOL)portraitFullScreen
{
    _portraitFullScreen = portraitFullScreen;
}

#pragma mark - Private methods

- (void)addTapGesture {
    
    if (self.singleTap || self.doubleTap) {
        [self removeGestureRecognizer:self.singleTap];
        [self removeGestureRecognizer:self.doubleTap];
//        [self removeGestureRecognizer:self.panRecognizer];
    }
      
    // 单击
    self.singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapGesture:)];
    self.singleTap.delegate                = self;
    self.singleTap.numberOfTouchesRequired = 1; //手指数
    self.singleTap.numberOfTapsRequired    = 1;
    [self addGestureRecognizer:self.singleTap];
    
    // 双击(播放/暂停)
    self.doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTapGesture:)];
    self.doubleTap.delegate                = self;
    self.doubleTap.numberOfTouchesRequired = 1; //手指数
    self.doubleTap.numberOfTapsRequired    = 2;
    
    [self addGestureRecognizer:self.doubleTap];
    
    // 解决点击当前view时候响应其他控件事件
    [self.singleTap setDelaysTouchesBegan:YES];
    [self.doubleTap setDelaysTouchesBegan:YES];
    // 双击失败响应单击事件
    [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
    
    
//    // 单击手势
//    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
//    //singleTap.delegate = self;
//    [self addGestureRecognizer:self.singleTap];
//    // 双击手势
//    self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGesture:)];
//    self.doubleTap.numberOfTapsRequired = 2;
//    [self addGestureRecognizer:self.doubleTap];
//    // 解决双击手势和单击手势冲突
//    [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
}

- (void)addPanGesture {
    
    if (self.panRecognizer) {
//        [self removeGestureRecognizer:self.singleTap];
//        [self removeGestureRecognizer:self.doubleTap];
        [self removeGestureRecognizer:self.panRecognizer];
    }
    
    // 添加平移手势，用来控制音量、亮度、快进快退
    self.panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    self.panRecognizer.delegate = self;
    [self.panRecognizer setMaximumNumberOfTouches:1];
    [self.panRecognizer setDelaysTouchesBegan:YES];
    [self.panRecognizer setDelaysTouchesEnded:YES];
    [self.panRecognizer setCancelsTouchesInView:YES];
    [self addGestureRecognizer:self.panRecognizer];
}

- (void)removePanGesture {
    [self removeGestureRecognizer:self.panRecognizer];
    self.panRecognizer = nil;
}

// 添加MPVolumeView
- (void)addMPVolumeView {
    self.volumeTool = [[NSNiceYSVolumeTool alloc] init];
    [self addSubview:self.volumeTool.mpVolumeView];
}

// 获取运营商信息
- (void)loadCarrier {
    __weak typeof(self) weakSelf = self;
    [CfipyYSCarrierTool loadCarrier:^(NSString * _Nonnull carrierName) {
        weakSelf.carrierLbl.text = carrierName;
    }];
}

// 获取网络信息
- (void)loadNetworkInfo {
    __weak typeof(self) weakSelf = self;
    [MMoogYSNetworkInfoTool loadNetworkInfo:^(NSString * _Nonnull info) {
        weakSelf.networkInfoLbl.text = info;
    }];
}

// 获取电池信息
- (void)loadBatteryInfo {
    __weak typeof(self) weakSelf = self;
    self.batteryTool = [UUaksYSBatteryTool batteryToolWithStatus:^(NSString * _Nonnull status, UIColor *color) {
        weakSelf.batteryStateLbl.text = status;
        [weakSelf changeBatteryColor:color];
    } level:^(float level, UIColor *color) {
        weakSelf.batteryLevelLbl.text = [NSString stringWithFormat:@"%.0f%%", level * 100];
        [weakSelf changeBatteryColor:color];
    }];
}

// 改变电池颜色
- (void)changeBatteryColor:(UIColor *)color {
    self.batteryStateLbl.textColor = color;
    self.batteryLevelLbl.textColor = color;
}

// 初始化屏幕亮度
- (void)initScreenBrightness {
    self.volumeTipLbl.text = @"亮度";
    self.volumeProgressView.progress = [KSasxYSScreenBrightnessTool getBrightness];
}

// 初始化系统音量
- (void)initSystemVolume {
    self.volumeTipLbl.text = @"音量";
    self.volumeProgressView.progress = self.volumeTool.volume;
}

// 改变屏幕亮度
- (void)changeBrightness:(CGFloat)deltaY {
    CGFloat brightness = [KSasxYSScreenBrightnessTool getBrightness];
    brightness -= deltaY;
    [KSasxYSScreenBrightnessTool changeBrightness:brightness];
    self.volumeProgressView.progress = brightness;
}

// 改变系统音量
- (void)changeVolume:(CGFloat)deltaY {
    float volume = self.volumeTool.volume;
    volume -= deltaY;
    self.volumeTool.volume = volume;
    self.volumeProgressView.progress = volume;
}

- (void)changeSlideProgressView:(CGFloat)deltaX progress:(CGFloat)progress
{
//    if (deltaX > 0) {
//        [self.slideDirectionImageView setImage:[UIImage imageNamed:@"gurk_video_forward_icon"]];
//    }else{
//        [self.slideDirectionImageView setImage:[UIImage imageNamed:@"gurk_video_backward_icon"]];
//    }
    self.slideProgressView.progress = progress;
    if (self.slideProgressView.progress > 1.0) {
        self.slideProgressView.progress = 1.0;
    }
    if (self.slideProgressView.progress < 0.0) {
        self.slideProgressView.progress = 0.0;
    }
    self.totalTimeLabel.text = [NSString stringWithFormat:@"/%@", [self formatTime:self.totalTime]];
    
    NSTimeInterval thisSlideTime = self.totalTime * self.slideProgressView.progress;
    self.slideTimeLabel.text = [self formatTime: thisSlideTime];
    
    if (thisSlideTime > self.currentSlideTime) {
        [self.slideDirectionImageView setImage:[UIImage imageNamed:@"gurk_video_forward_icon"]];
    }else if (thisSlideTime < self.currentSlideTime){
        [self.slideDirectionImageView setImage:[UIImage imageNamed:@"gurk_video_backward_icon"]];
    }
    
    self.currentSlideTime = thisSlideTime;
}
//是否立刻隐藏
- (void)toggleBarImmediately:(BOOL)immediately {
    
    self.hideBar = !self.isHideBar;
//    self.navBarTopConstraint.constant = self.hideBar ? -NAV_BAR_HEIGHT : 0;
    
    if (self.portraitFullScreen) {
        self.toolBarBottomConstraint.constant = self.hideBar ? -TOOL_BAR_HEIGHT : 20;
        if ([BlysaBJUtility isIPhoneXSeries]) {
            self.navBarTopConstraint.constant = self.hideBar ? -NAV_BAR_HEIGHT : 44;
        }else{
            self.navBarTopConstraint.constant = self.hideBar ? -NAV_BAR_HEIGHT : 0;
        }
    }else{
        self.toolBarBottomConstraint.constant = self.hideBar ? -TOOL_BAR_HEIGHT : 0;
        self.navBarTopConstraint.constant = self.hideBar ? -NAV_BAR_HEIGHT : 0;
    }
   
    if (immediately) {
        [self layoutIfNeeded];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (self.hideBar) {
        
        if (self.isPlaying) {
            self.rePlayBtn.hidden = YES;
            self.rePauseBtn.hidden = YES;
        }else{
            self.rePlayBtn.hidden = NO;
            self.rePauseBtn.hidden = YES;
        }
       
    }else{
        
        if (self.isPlaying) {
            self.rePlayBtn.hidden = YES;
            self.rePauseBtn.hidden = NO;
        }else{
            self.rePlayBtn.hidden = NO;
            self.rePauseBtn.hidden = YES;
        }
    }
    if (self.isHideBar) {
        [self invalidTimer];
    } else {
        [self resetTimer];
    }
    
}
// 隐藏或显示toolBar和navBar
- (void)toggleBar {
    [self toggleBarImmediately:NO];
}

// 格式化时间
- (NSString *)formatTime:(NSInteger)time {
    NSInteger minutes = time / 60;
    NSInteger seconds = time % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
}

// 重置timer
- (void)resetTimer {
    [self invalidTimer];
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer timerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [weakSelf toggleBar];
        }];
    } else {
        kWeakSelf
        self.timer = [NSTimer timerWithTimeInterval:5 target:weakSelf selector:@selector(toggleBar) userInfo:nil repeats:NO];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 让timer失效
- (void)invalidTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)startTimeTimer {
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        self.timeTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf setSystemTime];
        }];
    } else {
        kWeakSelf
        self.timeTimer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(setSystemTime) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timeTimer forMode:NSRunLoopCommonModes];
}

- (void)invalidTimeTimer {
    if (self.timeTimer) {
        [self.timeTimer invalidate];
        self.timeTimer = nil;
    }
}

// 设置系统时间
- (void)setSystemTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    self.timeLbl.text = [formatter stringFromDate:date];
}

#pragma mark - dealloc

- (void)dealloc {
    [self invalidTimer];
    [self invalidTimeTimer];
    NSLog(@"%s", __func__);
}

@end
