//
//  YSPlayerController.m
//  ijkplayerDemo
//
//  Created by 张延深 on 2020/4/13.
//  Copyright © 2020 张延深. All rights reserved.
//

#import "YSPlayerController.h"
#import "YSPlayerView.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PLMediaInfo.h"

@interface YSPlayerController () <YSPlayerControlDelegate>

@property (strong, nonatomic) YSPlayerView *playerView;
@property (strong, nonatomic) id<IJKMediaPlayback> player;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic, getter=isFullScreen) BOOL fullScreen;
@property (strong, nonatomic) PLMediaInfo *pLMediaInfo;

@end

@implementation YSPlayerController

- (instancetype)initWithContentMediaInfo:(PLMediaInfo *)mPLMediaInfo {
    if (self = [super init]) {
        
        self.pLMediaInfo = mPLMediaInfo;
        [self.playerView setThumbWithUrl:mPLMediaInfo.thumbURL];
    }
    return self;
}

-(void)setMediaInfo:(PLMediaInfo *)mPLMediaInfo
{
    self.pLMediaInfo = mPLMediaInfo;
    [self.playerView setThumbWithUrl:mPLMediaInfo.thumbURL];
}


-(CGFloat)videoWidth
{
    if (!self.player) {
        return 0;
    }
    return self.player.naturalSize.width;
}

-(CGFloat)videoHeight
{
    if (!self.player) {
        return 0;
    }
    return self.player.naturalSize.height;
}

#pragma mark - YSPlayerControlDelegate

- (void)initPlayAndPrepareToPlay
{
    
    [self shutdown];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    [options setOptionIntValue:IJK_AVDISCARD_DEFAULT forKey:@"skip_frame" ofCategory:kIJKFFOptionCategoryCodec];
    [options setOptionIntValue:IJK_AVDISCARD_DEFAULT forKey:@"skip_loop_filter" ofCategory:kIJKFFOptionCategoryCodec];
    
    //播放器缓冲可以避免因为丢帧引入花屏的，因为丢帧都是丢到I帧之前的P/B帧为止。我之前也写过一个类似的，思路都是一样，但这个代码更精简。
    //A：如果你想要实时性，可以去掉缓冲区，一句代码：
    //B: 如果你这样试过，发现你的项目中播放频繁卡顿，
    //你想留1-2秒缓冲区，让数据更平缓一些，
    //那你可以选择保留缓冲区，不设置上面那个就行。
//    [options setPlayerOptionIntValue:0 forKey:@"packet-buffering"];  //  关闭播放器缓冲
    //开启硬件解码
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    
    // 解决音视频不同步的问题
    [options setPlayerOptionIntValue:1 forKey:@"framedrop"];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.pLMediaInfo.videoURL] withOptions:options];
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.playbackRate = 1.0;
    
    self.player.shouldAutoplay = YES;
    [self.player setScalingMode:IJKMPMovieScalingModeAspectFit];
    [self.player prepareToPlay];
    
    [self.playerView insertSubview:self.player.view atIndex:0];
    // 添加约束
    [self addContraints];
    // 重置timer
    [self resetTimer];
    // 添加通知
    [self addNotifications];
    
    [self.delegate startPlay:self];
}

- (void)done {
    // 如果是全屏，就关闭全屏
    if (self.isFullScreen) {
        [self fullScreen];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(playerControllerDidClickDone:)]) {
        [self.delegate playerControllerDidClickDone:self];
    }
}

- (void)playOrPause {
    if (!self.player) {
        return;
    }
    if (self.player.isPlaying) {
        [self.player pause];
    } else {
        [self.player play];
        [self.delegate startPlay:self];
    }
    self.playerView.playControl.playing = self.player.isPlaying;
}

- (void)pause {
    if (!self.player) {
        return;
    }
    if ([self.player isPlaying]) {
        [self.player pause];
    }
    self.playerView.playControl.playing = self.player.isPlaying;
    
}

- (void)play {
    
    if (!self.player) {
        return;
    }
    
    if (self.player.isPlaying) {
        return;
    } else {
        [self.player play];
    }
    self.playerView.playControl.playing = self.player.isPlaying;
    [self.delegate startPlay:self];
}

- (void)stop {
    
    if (!self.player) {
        return;
    }
    
    [self.player stop];
    self.playerView.playControl.playing = self.player.isPlaying;
}

- (void)shutdown {
    
    if (!self.player) {
        return;
    }
    [self stop];
    [self.player shutdown];
    self.playerView.playControl.playing = self.player.isPlaying;
    [self.player.view removeFromSuperview];
    self.playerView.thumbView.hidden = NO;
}

- (void)progressChangeStart {
    
    if (!self.player) {
        return;
    }
    [self invalidTimer];
    [self.player pause];
}

- (void)didChangeProgress:(CGFloat)progress {
    
    if (!self.player) {
        return;
    }
    
    NSTimeInterval time = self.player.duration * progress;
    [self.player setCurrentPlaybackTime:time];
}

- (void)progressChangeEnd {
    
    if (!self.player) {
        return;
    }
    
    [self resetTimer];
    [self.player play];
}

- (void)fullScreen {
    
//    (UIDeviceOrientation)or {
//        
//        if (!self.isPoratFullScreen && or == self.deviceOrientation) return;
//        if (!(UIDeviceOrientationPortrait == or || UIDeviceOrientationLandscapeLeft == or || UIDeviceOrientationLandscapeRight == or)) return;
//        
//        BOOL isFirst = UIDeviceOrientationUnknown == self.deviceOrientation;
//        
//        if (or == UIDeviceOrientationPortrait) {
            
    if (self.fullScreen) {
        //退出全屏
        if (!self.portFullScreening) {
            [UIView animateWithDuration:.3 animations:^{
                self.view.transform = CGAffineTransformMakeRotation(0);
            }];
        }

        if ([self.delegate respondsToSelector:@selector(playerExitFullScreen:)]) {
            [self.delegate playerExitFullScreen:self];
        }
        self.fullScreen = NO;
        self.portFullScreening = NO;
    }else{
        //进入全屏
//        if (UIDeviceOrientationLandscapeRight == [[UIDevice currentDevice]orientation]) {
//            [self transformWithOrientation:UIDeviceOrientationLandscapeRight];
//        } else {
//            [self transformWithOrientation:UIDeviceOrientationLandscapeLeft];
//        }
        if (self.needPortFullScreen && self.videoWidth < self.videoHeight) {
            NSLog(@"竖屏全屏");
            self.portFullScreening = YES;
        }else{
            
            [UIView animateWithDuration:0.3 animations:^{
                self.view.transform = UIDeviceOrientationLandscapeLeft == [[UIDevice currentDevice]orientation] ? CGAffineTransformMakeRotation(M_PI/2) : CGAffineTransformMakeRotation(3*M_PI/2);
            }];
        }
       
        if ([self.delegate respondsToSelector:@selector(playerControllerDidClickFullScreen:)]) {
            [self.delegate playerControllerDidClickFullScreen:self];
        }
        self.fullScreen = YES;
    }
    
    self.playerView.playControl.portraitFullScreen = self.portFullScreening;
    self.playerView.playControl.fullScreen = self.fullScreen;
    
//    self.fullScreen = !self.isFullScreen;
//    self.playerView.playControl.fullScreen = self.fullScreen;
//    if ([self.delegate respondsToSelector:@selector(playerControllerDidClickFullScreen:)]) {
//        [self.delegate playerControllerDidClickFullScreen:self];
//    }
}

- (void)setPlaybackRate:(CGFloat)playbackRate {
    
    if (!self.player) {
        return;
    }
    
    self.player.playbackRate = playbackRate;
}

#pragma mark - Event response

- (void)handleLoadStateDidChangeNotification:(NSNotification *)notification {
    IJKMPMovieLoadState loadState = self.player.loadState;
    self.playerView.playControl.prepareToPlay = (loadState & IJKMPMovieLoadStatePlaythroughOK) != 0 || (loadState & IJKMPMovieLoadStatePlayable) != 0;
}

- (void)handlePlaybackStateDidChangeNotification:(NSNotification *)notification {
    IJKMPMoviePlaybackState playbackState = self.player.playbackState;
    self.playerView.playControl.playing = (playbackState == IJKMPMoviePlaybackStatePlaying);
}

- (void)handlePlaybackDidFinishNotification:(NSNotification *)notification {
    [self invalidTimer];
    [self.playerView.playControl playbackComplete];
}

// 准备开始播放了
- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}



#pragma mark - 应用进入后台
- (void)addBackgroundNotificationObservers {
    // app退到后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    // app进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)removeBackgroundNotificationObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)appWillEnterBackground {
   
    [self pause];
    
}

- (void)appDidEnterPlayGround {
    
    [self play];
}

#pragma mark - Setters/Getters

- (YSPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[YSPlayerView alloc] init];
//        _playerView.userInteractionEnabled = YES;
        _playerView.playControl.delegate = self;
        _playerView.mYSPlayerControlDelegate = self;
    }
    return _playerView;
}

- (UIView *)view {
    return self.playerView;
}

#pragma mark - Private methods

- (void)addContraints {
    
    if (!self.player) {
        return;
    }
    
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.playerView);
    }];
}

- (void)resetTimer {
    [self invalidTimer];
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf setPlayTimeAndTotalTime];
        }];
    } else {
        self.timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(setPlayTimeAndTotalTime) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)invalidTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

// 设置播放时长和总时长
- (void)setPlayTimeAndTotalTime {
    [self.playerView.playControl setPlayTime:self.player.currentPlaybackTime
                                   totalTime:self.player.duration];
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadStateDidChangeNotification:) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlaybackStateDidChangeNotification:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePlaybackDidFinishNotification:) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
}

- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - dealloc

- (void)dealloc {
    [self invalidTimer];
    [self removeNotifications];
    NSLog(@"%s", __func__);
}

@end
