//
//  YSPlayerController.h
//  ijkplayerDemo
//
//  Created by 张延深 on 2020/4/13.
//  Copyright © 2020 张延深. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSPlayerControlDelegate.h"

@import IJKMediaFramework;

@class YSPlayerController;

NS_ASSUME_NONNULL_BEGIN

@protocol YSPlayerControllerDelegate <NSObject>

@optional
- (void)playerControllerDidClickDone:(YSPlayerController *)playerController;
- (void)playerControllerDidClickFullScreen:(YSPlayerController *)playerController;
- (void)playerExitFullScreen:(YSPlayerController *)playerController;
- (void)startPlay:(YSPlayerController *)playerController;
@end

@interface YSPlayerController : NSObject

- (instancetype)initWithContentMediaInfo:(PLMediaInfo *)mPLMediaInfo;
-(void)setMediaInfo:(PLMediaInfo *)mPLMediaInfo;
//-(void) initPlayAndPrepareToPlay;

- (void)shutdown;

- (void)stop;

- (void)play;


- (void)pause;

@property (weak, nonatomic) id<YSPlayerControllerDelegate> delegate;
@property (strong, nonatomic, readonly) UIView *view;
@property (strong, nonatomic, readonly) id<IJKMediaPlayback> player;
@property (assign, nonatomic, readonly, getter=isFullScreen) BOOL fullScreen;

@property (assign, nonatomic) CGFloat videoWidth;

@property (assign, nonatomic) CGFloat videoHeight;

//视频宽度小于高度 是否需要竖屏全屏
@property (assign, nonatomic) BOOL needPortFullScreen;
//是否竖屏全屏中
@property (assign, nonatomic) BOOL portFullScreening;
@end

NS_ASSUME_NONNULL_END