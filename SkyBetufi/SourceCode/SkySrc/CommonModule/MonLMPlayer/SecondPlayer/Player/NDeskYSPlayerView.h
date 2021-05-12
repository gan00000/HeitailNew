//
//  NDeskYSPlayerView.h
//  ijkplayerDemo
//
//  Created by 张延深 on 2020/4/13.
//  Copyright © 2020 张延深. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSPlayerControlProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NDeskYSPlayerView : UIView

-(void) playBtnClickNow;

-(void) setThumbWithUrl:(NSString *)url;
-(void) playbackComplete;

-(void) setFullScreen:(BOOL) isFullScreen portaitFullScreen:(BOOL) portaitFullScreen;

-(void) setBgImage:(UIImage *)mUIImage videoWidth:(CGFloat) w videoHeight:(CGFloat)h;

@property (strong, nonatomic, readonly) id<YSPlayerControlProtocol> playControl;

@property (strong, nonatomic) id<YSPlayerControlDelegate> mYSPlayerControlDelegate;


@property (strong, nonatomic) UIView *thumbView;

@end

NS_ASSUME_NONNULL_END
