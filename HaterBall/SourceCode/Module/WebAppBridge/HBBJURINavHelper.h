#import <Foundation/Foundation.h>
@interface HBBJURINavHelper : NSObject
+ (BOOL)canHandleURI:(NSString *)uri;
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController;
@end
