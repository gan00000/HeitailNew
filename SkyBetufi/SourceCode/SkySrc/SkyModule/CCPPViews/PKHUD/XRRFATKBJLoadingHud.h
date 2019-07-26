//
//  XRRFATKBJLoadingHud.h
//  Exchange
//
//  Created by Marco on 2017/3/8.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XRRFATKBJLoadingHud : NSObject

+ (void)showHUDInView:(UIView *)view;
+ (void)showHUDWithText:(NSString *)text inView:(UIView *)view;
+ (void)hideHUDInView:(UIView *)view;

@end
