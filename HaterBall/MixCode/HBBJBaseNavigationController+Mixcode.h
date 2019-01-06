#import <UIKit/UIKit.h>
#import "HBBJBaseNavigationController.h"

@interface HBBJBaseNavigationController (Mixcode)
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)preferredStatusBarStyleMixcode:(NSString *)mixcode;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)viewControllersNotHideTabBarMixcode:(NSString *)mixcode;
- (void)backAction:(UIButton *)button mixcode:(NSString *)mixcode;
- (void)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer mixcode:(NSString *)mixcode;
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated mixcode:(NSString *)mixcode;

@end
