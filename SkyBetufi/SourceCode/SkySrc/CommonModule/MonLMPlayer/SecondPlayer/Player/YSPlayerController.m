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

@interface YSPlayerController () <YSPlayerControlDelegate>

@property (strong, nonatomic) YSPlayerView *playerView;
@property (strong, nonatomic) id<IJKMediaPlayback> player;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic, getter=isFullScreen) BOOL fullScreen;

@end

@implementation YSPlayerController

- (instancetype)initWithContentURL:(NSURL *)contentURL {
    if (self = [super init]) {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        // 解决音视频不同步的问题
        [options setPlayerOptionIntValue:1 forKey:@"framedrop"];
        self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:contentURL withOptions:options];
        self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
        self.player.playbackRate = 1.0;
        [self.playerView insertSubview:self.player.view atIndex:0];
        // 添加约束
        [self addContraints];
        // 重置timer
        [self resetTimer];
        // 添加通知
        [self addNotifications];
    }
    return self;
}

#pragma mark - YSPlayerControlDelegate

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

- (void)play {
    if (self.player.isPlaying) {
        [self.player pause];
    } else {
        [self.player play];
    }
    self.playerView.playControl.playing = self.player.isPlaying;
}

- (void)progressChangeStart {
    [self invalidTimer];
    [self.player pause];
}

- (void)didChangeProgress:(CGFloat)progress {
    NSTimeInterval time = self.player.duration * progress;
    [self.player setCurrentPlaybackTime:time];
}

- (void)progressChangeEnd {
    [self resetTimer];
    [self.player play];
}

- (void)fullScreen {
    self.fullScreen = !self.isFullScreen;
    self.playerView.playControl.fullScreen = self.fullScreen;
    if ([self.delegate respondsToSelector:@selector(playerControllerDidClickFullScreen:)]) {
        [self.delegate playerControllerDidClickFullScreen:self];
    }
}

- (void)setPlaybackRate:(CGFloat)playbackRate {
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

#pragma mark - Setters/Getters

- (YSPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[YSPlayerView alloc] initWithFrame:CGRectZero];
        _playerView.playControl.delegate = self;
    }
    return _playerView;
}

- (UIView *)view {
    return self.playerView;
}

#pragma mark - Private methods

- (void)addContraints {
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
