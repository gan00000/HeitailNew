//
//  UITabBar+XRRFATKDRExtension.h
//  DRBasicKit
//
//  Created by 冯生伟 on 2019/3/15.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+XRRFATKDRExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (XRRFATKDRExtension)

+ (CGFloat)tabBarHeight;
+ (CGFloat)safeHeight;
+ (CGFloat)iPhoneXTabarSafeHeight;
- (CGFloat)tabBarHeight;

@end

NS_ASSUME_NONNULL_END
