//
//  BJNavigationController.m
//  zhugelicai
//
//  Created by Marco on 2017/5/19.
//  Copyright © 2017年 Marco. All rights reserved.
//

#import "XRRFATKPPXXBJBaseNavigationController.h"
#import "XRRFATKHTMatchHomeViewController.h"
#import "XRRFATKHTNewsHomeViewController.h"
#import "XRRFATKHTFilmHomeViewController.h"
#import "XRRFATKHTDataHomeViewController.h"
#import "XRRFATKHTRankHomeViewController.h"

@interface UINavigationController (UINavigationControllerPopHooker)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(nonnull UINavigationItem *)item;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implemention"
@implementation UINavigationController (UINavigationControllerPopHooker)
@end
#pragma clang diagnostic pop

@interface XRRFATKPPXXBJBaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@end

@implementation XRRFATKPPXXBJBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

#pragma mark -- 横屏在delegate中处理，这里先屏蔽
//- (BOOL)shouldAutorotate {
//    return self.topViewController.shouldAutorotate;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return self.topViewController.supportedInterfaceOrientations;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return self.topViewController.preferredInterfaceOrientationForPresentation;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    for(Class vcClass in [self viewControllersNotHideTabBar]) {
        if ([viewController isKindOfClass:vcClass]) {
            [super pushViewController:viewController animated:animated];
            return;
        }
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count > 1 ||
        (![self isKindOfClass:[XRRFATKHTMatchHomeViewController class]] &&
         ![self isKindOfClass:[XRRFATKHTNewsHomeViewController class]] &&
         ![self isKindOfClass:[XRRFATKHTFilmHomeViewController class]] &&
         ![self isKindOfClass:[XRRFATKHTDataHomeViewController class]] &&
         ![self isKindOfClass:[XRRFATKHTRankHomeViewController class]])) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_back"]
                                                                                           style:UIBarButtonItemStylePlain
                                                                                          target:self
                                                                                          action:@selector(backAction:)];
        viewController.navigationItem.hidesBackButton = YES;
    }
}

#pragma mark -
- (NSArray<Class> *)viewControllersNotHideTabBar {
    return nil;
}

#pragma mark - Back Action
- (void)backAction:(UIButton *)button {
    UIViewController *viewController = self.topViewController;
    
    if ([viewController respondsToSelector:@selector(bj_shouldHandlePopActionMySelf)]) {
        if ([(id<BJNavigationDelegate>)viewController bj_shouldHandlePopActionMySelf]) {
            if ([viewController respondsToSelector:@selector(bj_handlePopActionMySelf)]) {
                [(id<BJNavigationDelegate>)viewController bj_handlePopActionMySelf];
            }
            return; //自定义返回按钮点击事件
        }
    }
    if (self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count == 1) {
        return NO;
    }
    UIViewController *viewController = self.topViewController;
    if ([viewController respondsToSelector:@selector(bj_shouldForbidSlideBackAction)]) {
        BJLog(@"can slide back: %d", ![(id<BJNavigationDelegate>)viewController bj_shouldForbidSlideBackAction]);
        return ![(id<BJNavigationDelegate>)viewController bj_shouldForbidSlideBackAction];
    } else {
        return YES;
    }
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL hidde = NO;
    if ([viewController respondsToSelector:@selector(bj_shouldHideNavigationBar)]) {
        hidde = [(id<BJNavigationDelegate>)viewController bj_shouldHideNavigationBar];
    }
    [self setNavigationBarHidden:hidde animated:YES];
}

@end
