#import "SkyBallHetiRedBJURINavHelper.h"
#import "SkyBallHetiRedBJWebViewController.h"
#import "SkyBallHetiRedPPXXBJViewControllerCenter.h"
#import "SkyBallHetiRedBJURINavigator.h"
@implementation SkyBallHetiRedBJURINavHelper
+ (BOOL)canHandleURI:(NSString *)uri {
    if ([[SkyBallHetiRedBJURINavigator sharedInstance] canHandleURI:uri]) {
        return YES;
    }
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController {
    BOOL result = [[SkyBallHetiRedBJURINavigator sharedInstance] handleURI:uri];
    if (!result) {
        SkyBallHetiRedBJWebViewController *webVC = [[SkyBallHetiRedBJWebViewController alloc] initWithAddress:uri];
        UINavigationController *navCon = nil;
        if (!viewController) {
            navCon = [SkyBallHetiRedPPXXBJViewControllerCenter currentViewController].navigationController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            navCon = (UINavigationController *)viewController;
        } else {
            navCon = viewController.navigationController;
        }
        [navCon pushViewController:webVC animated:YES];
    }
}
@end
