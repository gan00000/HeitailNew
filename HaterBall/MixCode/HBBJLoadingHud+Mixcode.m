#import "HBBJLoadingHud+Mixcode.h"
@implementation HBBJLoadingHud (Mixcode)
+ (void)showHUDInView:(UIView *)view mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)showHUDWithText:(NSString *)text inView:(UIView *)view mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)hideHUDInView:(UIView *)view mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
