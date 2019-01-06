#import "HBBJURINavHelper+Mixcode.h"
@implementation HBBJURINavHelper (Mixcode)
+ (void)canHandleURI:(NSString *)uri mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)handleURI:(NSString *)uri fromViewController:(UIViewController *)viewController mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
