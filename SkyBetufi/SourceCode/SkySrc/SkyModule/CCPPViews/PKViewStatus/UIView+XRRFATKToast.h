//
//  UIView+XRRFATKToast.h
//  Exchange
//
//  Created by Marco on 2017/3/7.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XRRFATKToast)

- (void)showToast:(NSString *)toast;
- (void)showToast:(NSString *)toast duration:(CGFloat)duration;

- (void)showToast:(NSString *)toast icon:(UIImage *)icon;
- (void)showToast:(NSString *)toast icon:(UIImage *)icon duration:(CGFloat)duration;

@end
