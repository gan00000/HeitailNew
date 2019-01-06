#import "HBBJURINavHelper.h"
#import "HBBJWebViewController.h"
#import "HBBJViewControllerCenter.h"
#import "HBBJURINavigator.h"
@implementation HBBJURINavHelper
+ (BOOL)canHandleURI:(NSString *)uri {
    if ([[HBBJURINavigator sharedInstance] canHandleURI:uri]) {
        return YES;
    }
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController {
    BOOL result = [[HBBJURINavigator sharedInstance] handleURI:uri];
    if (!result) {
        HBBJWebViewController *webVC = [[HBBJWebViewController alloc] initWithAddress:uri];
        UINavigationController *navCon = nil;
        if (!viewController) {
            navCon = [HBBJViewControllerCenter currentViewController].navigationController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            navCon = (UINavigationController *)viewController;
        } else {
            navCon = viewController.navigationController;
        }
        [navCon pushViewController:webVC animated:YES];
    }
}
@end
