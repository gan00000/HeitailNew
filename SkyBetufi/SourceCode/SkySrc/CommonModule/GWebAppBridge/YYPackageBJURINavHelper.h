#import <Foundation/Foundation.h>
@interface YYPackageBJURINavHelper : NSObject
+ (BOOL)canHandleURI:(NSString *)uri;
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController;
@end
