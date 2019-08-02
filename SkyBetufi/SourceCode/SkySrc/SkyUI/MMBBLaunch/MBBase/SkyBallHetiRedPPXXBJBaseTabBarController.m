#import "SkyBallHetiRedPPXXBJBaseTabBarController.h"
@interface SkyBallHetiRedPPXXBJBaseTabBarController ()
@end
@implementation SkyBallHetiRedPPXXBJBaseTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<UIViewController *> *tabControllers = [self waterSkytabBarControllers];
    NSArray<UIImage *> *icons = [self waterSkytabBarIcons];
    NSArray<UIImage *> *selIcons = [self waterSkytabBarSelectedIcons];
    NSArray<NSString *> *titles = [self waterSkytabBarTitles];
    for (int i = 0; i < tabControllers.count; i++) {
        UIImage *tabIcon = nil;
        UIImage *tabSelIcon = nil;
        NSString *title = @"";
        if (icons.count > i) {
            tabIcon = icons[i];
        }
        if (selIcons.count > i) {
            tabSelIcon = selIcons[i];
        }
        if (titles.count > i) {
            title = titles[i];
        }
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:tabIcon selectedImage:tabSelIcon];
        UIViewController *controller = tabControllers[i];
        controller.tabBarItem = tabBarItem;
    }
    self.viewControllers = tabControllers;
}
- (BOOL)shouldAutorotate {
    return [[self selectedViewController] shouldAutorotate];
}
#pragma mark -
- (NSArray<UIImage *> *)waterSkytabBarIcons {
    return nil;
}
- (NSArray<UIImage *> *)waterSkytabBarSelectedIcons {
    return nil;
}
- (NSArray<NSString *> *)waterSkytabBarTitles {
    return nil;
}
- (NSArray<UIViewController *> *)waterSkytabBarControllers {
    return nil;
}
@end
