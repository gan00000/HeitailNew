#import "UIView+ToastMixcode.h"
@implementation UIView (ToastMixcode)
- (void)showToast:(NSString *)toast duration:(CGFloat)duration mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)showToast:(NSString *)toast mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)showToast:(NSString *)toast icon:(UIImage *)icon mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)showToast:(NSString *)toast icon:(UIImage *)icon duration:(CGFloat)duration mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
