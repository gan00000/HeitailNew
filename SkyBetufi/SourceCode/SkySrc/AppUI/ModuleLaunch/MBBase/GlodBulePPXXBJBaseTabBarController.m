#import "GlodBulePPXXBJBaseTabBarController.h"
@interface GlodBulePPXXBJBaseTabBarController ()
@end
@implementation GlodBulePPXXBJBaseTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<UIViewController *> *tabControllers = [self taotabBarControllers];
    NSArray<UIImage *> *icons = [self taotabBarIcons];
    NSArray<UIImage *> *selIcons = [self taotabBarSelectedIcons];
    NSArray<NSString *> *titles = [self taotabBarTitles];
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
        [controller viewWillAppear:YES];
        [controller viewDidAppear:YES];
        controller.tabBarItem = tabBarItem;
    }
    self.viewControllers = tabControllers;
}
- (BOOL)shouldAutorotate {
    return [[self selectedViewController] shouldAutorotate];
}
#pragma mark -
- (NSArray<UIImage *> *)taotabBarIcons {
    return nil;
}
- (NSArray<UIImage *> *)taotabBarSelectedIcons {
    return nil;
}
- (NSArray<NSString *> *)taotabBarTitles {
    return nil;
}
- (NSArray<UIViewController *> *)taotabBarControllers {
    return nil;
}
@end
