#import "GlodBuleBJURINavHelper.h"
#import "GlodBuleBJWebViewController.h"
#import "GlodBulePPXXBJViewControllerCenter.h"
#import "GlodBuleBJURINavigator.h"
@implementation GlodBuleBJURINavHelper
+ (BOOL)canHandleURI:(NSString *)uri {
    if ([[GlodBuleBJURINavigator sharedInstance] canHandleURI:uri]) {
        return YES;
    }
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController {
    BOOL result = [[GlodBuleBJURINavigator sharedInstance] handleURI:uri];
    if (!result) {
        GlodBuleBJWebViewController *webVC = [[GlodBuleBJWebViewController alloc] initWithAddress:uri];
        UINavigationController *navCon = nil;
        if (!viewController) {
            navCon = [GlodBulePPXXBJViewControllerCenter currentViewController].navigationController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            navCon = (UINavigationController *)viewController;
        } else {
            navCon = viewController.navigationController;
        }
        [navCon pushViewController:webVC animated:YES];
    }
}
@end
