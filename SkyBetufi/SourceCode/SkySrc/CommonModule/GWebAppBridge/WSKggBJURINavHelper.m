#import "WSKggBJURINavHelper.h"
#import "MMoogBJWebViewController.h"
#import "UUaksPPXXBJViewControllerCenter.h"
#import "YeYeeBJURINavigator.h"
@implementation WSKggBJURINavHelper
+ (BOOL)canHandleURI:(NSString *)uri {
    if ([[YeYeeBJURINavigator sharedInstance] canHandleURI:uri]) {
        return YES;
    }
    if ([uri hasPrefix:@"http://"] || [uri hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController {
    BOOL result = [[YeYeeBJURINavigator sharedInstance] handleURI:uri];
    if (!result) {
        MMoogBJWebViewController *webVC = [[MMoogBJWebViewController alloc] initWithAddress:uri];
        UINavigationController *navCon = nil;
        if (!viewController) {
            navCon = [UUaksPPXXBJViewControllerCenter currentViewController].navigationController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            navCon = (UINavigationController *)viewController;
        } else {
            navCon = viewController.navigationController;
        }
        [navCon pushViewController:webVC animated:YES];
    }
}
@end
