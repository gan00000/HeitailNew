#import "XRRFATKBJURINavHelper.h"
#import "XRRFATKBJWebViewController.h"
#import "XRRFATKPPXXBJViewControllerCenter.h"
#import "XRRFATKBJURINavigator.h"
@implementation XRRFATKBJURINavHelper
+ (BOOL)canHandleURI:(NSString *)uri {
    if ([[XRRFATKBJURINavigator sharedInstance] canHandleURI:uri]) {
        return YES;
    }
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController {
    BOOL result = [[XRRFATKBJURINavigator sharedInstance] handleURI:uri];
    if (!result) {
        XRRFATKBJWebViewController *webVC = [[XRRFATKBJWebViewController alloc] initWithAddress:uri];
        UINavigationController *navCon = nil;
        if (!viewController) {
            navCon = [XRRFATKPPXXBJViewControllerCenter currentViewController].navigationController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            navCon = (UINavigationController *)viewController;
        } else {
            navCon = viewController.navigationController;
        }
        [navCon pushViewController:webVC animated:YES];
    }
}
@end
