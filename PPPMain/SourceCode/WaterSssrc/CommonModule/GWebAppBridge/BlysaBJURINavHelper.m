#import "BlysaBJURINavHelper.h"
#import "FFlaliBJWebViewController.h"
#import "CfipyPPXXBJViewControllerCenter.h"
#import "UUaksBJURINavigator.h"
@implementation BlysaBJURINavHelper
+ (BOOL)canHandleURI:(NSString *)uri {
    if ([[UUaksBJURINavigator sharedInstance] canHandleURI:uri]) {
        return YES;
    }
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController {
    BOOL result = [[UUaksBJURINavigator sharedInstance] handleURI:uri];
    if (!result) {
        FFlaliBJWebViewController *webVC = [[FFlaliBJWebViewController alloc] initWithAddress:uri];
        UINavigationController *navCon = nil;
        if (!viewController) {
            navCon = [CfipyPPXXBJViewControllerCenter currentViewController].navigationController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            navCon = (UINavigationController *)viewController;
        } else {
            navCon = viewController.navigationController;
        }
        [navCon pushViewController:webVC animated:YES];
    }
}
@end
