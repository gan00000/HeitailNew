#import <Foundation/Foundation.h>
@interface GlodBuleBJURINavHelper : NSObject
+ (BOOL)canHandleURI:(NSString *)uri;
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController;
@end
