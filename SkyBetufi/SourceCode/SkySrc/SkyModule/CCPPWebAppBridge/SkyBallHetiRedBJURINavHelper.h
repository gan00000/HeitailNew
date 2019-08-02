#import <Foundation/Foundation.h>
@interface SkyBallHetiRedBJURINavHelper : NSObject
+ (BOOL)canHandleURI:(NSString *)uri;
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController;
@end
