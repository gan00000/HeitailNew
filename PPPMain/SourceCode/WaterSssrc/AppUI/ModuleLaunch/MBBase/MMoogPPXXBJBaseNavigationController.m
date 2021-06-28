#import "MMoogPPXXBJBaseNavigationController.h"
#import "FFlaliHTNewMatchHomeViewController.h"
#import "KSasxHTNewsHomeViewController.h"
#import "CfipyHTFilmHomeViewController.h"
#import "BlysaHTDataHomeViewController.h"
#import "WSKggHTRankHomeViewController.h"
#import "NSNiceHTMainPageViewController.h"
#import "UUaksMainLanmuViewController.h"

@interface UINavigationController (UINavigationControllerPopHooker)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(nonnull UINavigationItem *)item;
@end
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implemention"
@implementation UINavigationController (UINavigationControllerPopHooker)
@end
#pragma clang diagnostic pop
@interface MMoogPPXXBJBaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@end
@implementation MMoogPPXXBJBaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}
#pragma mark -- 横屏在delegate中处理，这里先屏蔽
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    for(Class vcClass in [self taoviewControllersNotHideTabBar]) {
        if ([viewController isKindOfClass:vcClass]) {
           
            [super pushViewController:viewController animated:animated];
            return;
        }
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1 ||
        (![self isKindOfClass:[FFlaliHTNewMatchHomeViewController class]] &&
         ![self isKindOfClass:[KSasxHTNewsHomeViewController class]] &&
         ![self isKindOfClass:[CfipyHTFilmHomeViewController class]] &&
         ![self isKindOfClass:[BlysaHTDataHomeViewController class]] &&
         ![self isKindOfClass:[NSNiceHTMainPageViewController class]] &&
         ![self isKindOfClass:[UUaksMainLanmuViewController class]] &&
         
         ![self isKindOfClass:[WSKggHTRankHomeViewController class]])) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"gurk_nav_icon_back"]
                                                                                           style:UIBarButtonItemStylePlain
                                                                                          target:self
                                                                                          action:@selector(backAction:)];
        viewController.navigationItem.hidesBackButton = YES;
    }
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

#pragma mark -
- (NSArray<Class> *)taoviewControllersNotHideTabBar {
    return nil;
}
#pragma mark - Back Action
- (void)backAction:(UIButton *)button {
    UIViewController *viewController = self.topViewController;
    if ([viewController respondsToSelector:@selector(tao_shouldHandlePopActionMySelf)]) {
        if ([(id<BJNavigationDelegate>)viewController tao_shouldHandlePopActionMySelf]) {
            if ([viewController respondsToSelector:@selector(tao_handlePopActionMySelf)]) {
                [(id<BJNavigationDelegate>)viewController tao_handlePopActionMySelf];
            }
            return;
        }
    }
    
    if ([viewController respondsToSelector:@selector(tao_handleNavBack)]) {
        [(id<BJNavigationDelegate>)viewController tao_handleNavBack];
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
    if ([viewController respondsToSelector:@selector(tao_shouldForbidSlideBackAction)]) {
        BJLog(@"can slide back: %d", ![(id<BJNavigationDelegate>)viewController tao_shouldForbidSlideBackAction]);
        return ![(id<BJNavigationDelegate>)viewController tao_shouldForbidSlideBackAction];
    } else {
        return YES;
    }
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL hidde = NO;
    if ([viewController respondsToSelector:@selector(tao_shouldHideNavigationBar)]) {
        hidde = [(id<BJNavigationDelegate>)viewController tao_shouldHideNavigationBar];
    }
    [self setNavigationBarHidden:hidde animated:YES];
    [viewController viewWillAppear:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
//     [viewController viewDidAppear:YES];
    
}
@end
