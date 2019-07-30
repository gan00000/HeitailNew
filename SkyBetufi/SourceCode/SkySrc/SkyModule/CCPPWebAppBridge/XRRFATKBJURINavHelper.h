#import <Foundation/Foundation.h>
@interface XRRFATKBJURINavHelper : NSObject
+ (BOOL)canHandleURI:(NSString *)uri;
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController;
@end
