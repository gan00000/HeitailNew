#import "HBBJBaseNavigationController+Mixcode.h"
@implementation HBBJBaseNavigationController (Mixcode)
- (void)viewDidLoadMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)preferredStatusBarStyleMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)viewControllersNotHideTabBarMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)backAction:(UIButton *)button mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
