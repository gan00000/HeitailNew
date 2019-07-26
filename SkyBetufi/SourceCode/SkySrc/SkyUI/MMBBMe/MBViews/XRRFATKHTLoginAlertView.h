//
//  XRRFATKHTLoginAlertView.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/6.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HTLoginPlatform) {
    HTLoginPlatformFB,
    HTLoginPlatformLine
};

@interface XRRFATKHTLoginAlertView : UIView
    
+ (void)showLoginAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;

+ (void)showShareAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;

@end

NS_ASSUME_NONNULL_END
