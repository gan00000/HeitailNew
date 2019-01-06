#import <Foundation/Foundation.h>
#import "HBBJURINavHelper.h"
#import "HBBJWebViewController.h"
#import "HBBJViewControllerCenter.h"
#import "HBBJURINavigator.h"

@interface HBBJURINavHelper (Mixcode)
+ (void)canHandleURI:(NSString *)uri mixcode:(NSString *)mixcode;
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController mixcode:(NSString *)mixcode;

@end
