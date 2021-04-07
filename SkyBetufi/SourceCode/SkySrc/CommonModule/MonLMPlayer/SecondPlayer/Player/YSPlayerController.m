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

@property (assign, nonatomic) NSUInteger count;

@property (assign, nonatomic) NSTimeInterval seekTime;
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

- (void)initPlayAndPrepareToPlay:(NSInteger) tag
{
    
//    [self shutdown];
    
    if (self.player && !self.isShutdown) {
        
        if (tag == 100) {
            self.player.currentPlaybackTime = 0;
            [self play];
            return;
        }
        
        [self play];
        return;
    }
    
    self.isShutdown = NO;
    
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
    
    //设置缓存
//    mMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "cache_file_path",“/storage/emulated/0/1.tmp");每首歌的临时文件名自己根据自己需要生成就行了。
//            mMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "cache_map_path",“/storage/emulated/0/2.tmp"");//暂时不知道设置有什么用
//            mMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "parse_cache_map",
//                    1);
//            mMediaPlayer.setOption(IjkMediaPlayer.OPT_CATEGORY_FORMAT, "auto_save_map", 1);
    
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    NSString * filePath = self.pLMediaInfo.videoURL;
    //从路径中获得完整的文件名 （带后缀）
    NSString *fileName = [filePath lastPathComponent];
    NSString *fileNameNoExtension = [fileName stringByDeletingPathExtension];
    
    //获得文件名 （不带后缀）
//    NSString *fileName1 = [filePath stringByDeletingPathExtension];

    //获得文件的后缀名 （不带'.'）
//    NSString *suffix = [filePath pathExtension];
    
    NSString *fileDir = [cachesDir stringByAppendingPathComponent:@"thMovies"];
    NSString *fileCacheName = [[fileDir stringByAppendingPathComponent:fileNameNoExtension] stringByAppendingPathExtension:@"temp"];
    
    NSString *fileCacheNameMap = [[fileDir stringByAppendingPathComponent:fileNameNoExtension] stringByAppendingPathExtension:@"mapTemp"];
    NSLog(@"fileCacheName = %@",fileCacheName);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
     BOOL isDir = YES;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:fileDir isDirectory:&isDir];

    if (!existed) {
         // 在 Document 目录下创建一个 head 目录
        NSLog(@"创建缓存中间目录");
        [fileManager createDirectoryAtPath:fileDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [options setOptionValue:fileCacheName forKey:@"cache_file_path" ofCategory:(kIJKFFOptionCategoryFormat)];
    [options setOptionValue:fileCacheNameMap forKey:@"cache_map_path" ofCategory:(kIJKFFOptionCategoryFormat)];
    [options setOptionIntValue:1 forKey:@"parse_cache_map" ofCategory:(kIJKFFOptionCategoryFormat)];
    [options setOptionIntValue:1 forKey:@"auto_save_map" ofCategory:(kIJKFFOptionCategoryFormat)];
    
    NSString *cache_filePath = [NSString stringWithFormat:@"ijkio:cache:ffio:%@",filePath];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString: cache_filePath] withOptions:options];
//    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.playbackRate = 1.0;
    
    self.player.shouldAutoplay = YES;
    [self.player setScalingMode:IJKMPMovieScalingModeAspectFit];
    [self.player prepareToPlay];
    
    self.player.view.backgroundColor = UIColor.clearColor;
    [self.playerView insertSubview:self.player.view atIndex:1];
    // 添加约束
    [self addContraints];
    // 重置timer
//    [self resetTimer];
    // 添加通知
    [self addNotifications];
    
    [self.delegate willStartPlay:self];
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
        //[self.player pause];
        [self pause];
    } else {
//        [self.player play];
//        self.playerView.thumbView.hidden = YES;
//        [self.delegate startPlay:self];
//        [self resetTimer];
        [self play];
    }
//    self.playerView.playControl.playing = self.player.isPlaying;
    
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
    
//    if (self.player.isPlaying) {
//        return;
//    } else {
//
//    }
    [self.delegate willStartPlay:self];
    
    [self.player play];
    self.playerView.thumbView.hidden = YES;
//    [self resetTimer];
    self.playerView.playControl.playing = self.player.isPlaying;
   
}

- (void)stop {
    
    if (!self.player) {
        return;
    }
    
    [self.player stop];
    self.playerView.playControl.playing = self.player.isPlaying;
}

- (void)shutdown {
    
    [self stop];
    [self.player shutdown];
    
    [self invalidTimer];
    self.playerView.playControl.playing = self.player.isPlaying;
    [self.player.view removeFromSuperview];
    self.playerView.thumbView.hidden = NO;
    [self.playerView.playControl playbackShutDown];
    [self removeNotifications];
    self.fullScreen = NO;
    self.isShutdown = YES;
    self.player = nil;
}

- (void)playNowWithTime:(NSTimeInterval) time
{
    self.seekTime = time;
    [self.playerView playBtnClickNow];
//    [self pause];
//    self.player.currentPlaybackTime = self.seekTime;
//    [self play];
}

- (void)progressChangeStart {
    
    if (!self.player) {
        return;
    }
    [self invalidTimer];
//    [self pause];
}

- (void)didChangeProgress:(CGFloat)progress {
    
    if (!self.player) {
        return;
    }
    
    self.seekTime = floorf(self.player.duration * progress);
//    [self.player setCurrentPlaybackTime:time];
}

- (void)progressChangeEnd {
    
    if (!self.player) {
        return;
    }
    
    if (self.seekTime >= 0) {
        [self invalidTimer];
        [self pause];
        
        [self.player setCurrentPlaybackTime:self.seekTime];
        [self resetTimer];
    }

    //dispatch_queue_t queen = dispatch_get_global_queue(0, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self play];
    });
   
    self.seekTime = -1;
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
                self.view.transform = CGAffineTransformMakeRotation(M_PI/2);//UIDeviceOrientationLandscapeLeft == [[UIDevice currentDevice]orientation] ? CGAffineTransformMakeRotation(M_PI/2) : CGAffineTransformMakeRotation(3*M_PI/2);
            }];
        }
       
        if ([self.delegate respondsToSelector:@selector(playerControllerDidClickFullScreen:)]) {
            [self.delegate playerControllerDidClickFullScreen:self];
        }
        self.fullScreen = YES;
    }
    
    [self.playerView setFullScreen:self.fullScreen portaitFullScreen:self.portFullScreening];
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


/**
 准备播放             IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification;
 尺寸改变发出的通知     IJKMPMoviePlayerScalingModeDidChangeNotification;
 播放完成或者用户退出   IJKMPMoviePlayerPlaybackDidFinishNotification;
 播放完成或者用户退出的原因（key） IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey; // NSNumber (IJKMPMovieFinishReason)
 播放状态改变了        IJKMPMoviePlayerPlaybackStateDidChangeNotification;
 加载状态改变了        IJKMPMoviePlayerLoadStateDidChangeNotification;
 目前不知道这个代表啥          IJKMPMoviePlayerIsAirPlayVideoActiveDidChangeNotification;
 **/
#pragma mark - Event response

// 加载状态改变了
- (void)handleLoadStateDidChangeNotification:(NSNotification *)notification {
    NSLog(@"self.player 加载状态改变了 handleLoadStateDidChangeNotification");
    IJKMPMovieLoadState loadState = self.player.loadState;
    self.playerView.playControl.prepareToPlay = (loadState & IJKMPMovieLoadStatePlaythroughOK) != 0 || (loadState & IJKMPMovieLoadStatePlayable) != 0;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        // 加载完成，即将播放，停止加载的动画，并将其移除
        NSLog(@"加载完成, 自动播放了 LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
      
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {//停滞不前
        // 可能由于网速不好等因素导致了暂停，重新添加加载的动画
        NSLog(@"自动暂停了，loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStatePlayable) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlayable: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: %d\n", (int)loadState);
    }
}
//播放状态改变了
- (void)handlePlaybackStateDidChangeNotification:(NSNotification *)notification {
    NSLog(@"self.player 播放状态改变了 handlePlaybackStateDidChangeNotification");
    IJKMPMoviePlaybackState playbackState = self.player.playbackState;
    self.playerView.playControl.playing = (playbackState == IJKMPMoviePlaybackStatePlaying);
    
    if (self.player.playbackState == IJKMPMoviePlaybackStatePlaying) {
        //视频开始播放的时候开启计时器
        if (!self.timer) {
            [self resetTimer];
        }
        
    }
}

//播放完成或者用户退出
- (void)handlePlaybackDidFinishNotification:(NSNotification *)notification {
    NSLog(@"self.player 播放完成或者用户退出handlePlaybackDidFinishNotification");
    [self invalidTimer];
    [self.playerView playbackComplete];
    [self.playerView.playControl playbackComplete];
}

// 准备开始播放了
- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"self.player 准备开始播放了 mediaIsPrepareToPlayDidChange\n");
    
    if (self.seekTime > 0) {
        self.player.currentPlaybackTime = self.seekTime;
        self.seekTime = -1;
    }
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
    self.count = 0;
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer timerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf setPlayTimeAndTotalTime];
            
            if (self.count == 0 || self.count == 2) {
                [weakSelf.playerView setBgImage:weakSelf.player.thumbnailImageAtCurrentTime  videoWidth: self.videoWidth videoHeight: self.videoHeight];
                self.count = 0;
            }
            self.count = self.count + 1;
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
                            playableDuration:self.player.playableDuration
                                   totalTime:self.player.duration];
    
//    NSLog(@"self.player.bufferingProgress = %d", self.player.bufferingProgress);
//    NSLog(@"self.player.numberOfBytesTransferred = %ld", self.player.numberOfBytesTransferred);
//    NSLog(@"self.player.playableDuration = %ld", (NSInteger)self.player.playableDuration);
    
}

/**
 准备播放             IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification;
 尺寸改变发出的通知     IJKMPMoviePlayerScalingModeDidChangeNotification;
 播放完成或者用户退出   IJKMPMoviePlayerPlaybackDidFinishNotification;
 播放完成或者用户退出的原因（key） IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey; // NSNumber (IJKMPMovieFinishReason)
 播放状态改变了        IJKMPMoviePlayerPlaybackStateDidChangeNotification;
 加载状态改变了        IJKMPMoviePlayerLoadStateDidChangeNotification;
 目前不知道这个代表啥          IJKMPMoviePlayerIsAirPlayVideoActiveDidChangeNotification;
 **/
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
