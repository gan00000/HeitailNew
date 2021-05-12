#import "YYPackageBJURINavHelper.h"
#import "PXFunBJWebViewController.h"
#import "PXFunPPXXBJViewControllerCenter.h"
#import "YYPackageBJURINavigator.h"
@implementation YYPackageBJURINavHelper
+ (BOOL)canHandleURI:(NSString *)uri {
    if ([[YYPackageBJURINavigator sharedInstance] canHandleURI:uri]) {
        return YES;
    }
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController {
    BOOL result = [[YYPackageBJURINavigator sharedInstance] handleURI:uri];
    if (!result) {
        PXFunBJWebViewController *webVC = [[PXFunBJWebViewController alloc] initWithAddress:uri];
        UINavigationController *navCon = nil;
        if (!viewController) {
            navCon = [PXFunPPXXBJViewControllerCenter currentViewController].navigationController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            navCon = (UINavigationController *)viewController;
        } else {
            navCon = viewController.navigationController;
        }
        [navCon pushViewController:webVC animated:YES];
    }
}
@end
