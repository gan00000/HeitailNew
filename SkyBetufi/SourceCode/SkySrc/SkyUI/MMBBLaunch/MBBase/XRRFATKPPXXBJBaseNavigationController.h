//
//  BJNavigationController.h
//  zhugelicai
//
//  Created by Marco on 2017/5/19.
//  Copyright © 2017年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BJNavigationDelegate <NSObject>

@optional
/**
 是否捕捉返回按钮点击事件。

 @return 如果想要自定义返回按钮点击事件，返回YES；否则返回NO让系统自动处理。
 */
- (BOOL)bj_shouldHandlePopActionMySelf;


/**
 自定义的返回事件。bj_shouldHandlePopActionMySelf返回YES时才执行。
 */
- (void)bj_handlePopActionMySelf;

/*
 *  是否禁用滑动返回事件
 *
 *  @return YES 则不可滑动返回
 */
- (BOOL)bj_shouldForbidSlideBackAction;

/*
 *  是否在当前页面隐藏导航栏
 */
- (BOOL)bj_shouldHideNavigationBar;


@end

@interface XRRFATKPPXXBJBaseNavigationController : UINavigationController


/**
 BJNavigationController重写了pushViewController方法，每次push都会把viewController的hidesBottomBarWhenPushed属性设为YES，
 为了解决当UINavigationController包含在UITabBarController里面时，push后tabBar不自动隐藏的问题。也避免了每次push都要设置一次hidesBottomBarWhenPushed属性。
 
 而NavigationController最顶层的viewController并不需要把hidesBottomBarWhenPushed设为YES，否则会出现问题。
 
 因此这个方法便是用来过滤[包含在UITabBarController里的(UITabBarController的viewControllers属性)]每个UINavigationController最顶层的viewController。
 数组里的一个元素对应一个UINavigationController的顶层viewController
 
 @return ViewController的class数组
 */
- (NSArray<Class> *)viewControllersNotHideTabBar;

@end
