//
//  BJTabBarController.h
//  zhugelicai
//
//  Created by Marco on 2017/5/19.
//  Copyright © 2017年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRRFATKPPXXBJBaseTabBarController : UITabBarController

- (NSArray<UIImage *> *)tabBarIcons;
- (NSArray<UIImage *> *)tabBarSelectedIcons;
- (NSArray<NSString *> *)tabBarTitles;
- (NSArray<UIViewController *> *)tabBarControllers;

@end
