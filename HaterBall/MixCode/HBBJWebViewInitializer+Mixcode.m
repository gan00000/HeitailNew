#import "HBBJWebViewInitializer+Mixcode.h"
@implementation HBBJWebViewInitializer (Mixcode)
+ (void)sharedInstanceMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setupWebViewWithCompletion:(void (^)(void))completion mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
