#import <Foundation/Foundation.h>
@interface GlodBuleBJLoadingHud : NSObject
+ (void)showHUDInView:(UIView *)view;
+ (void)showHUDWithText:(NSString *)text inView:(UIView *)view;
+ (void)hideHUDInView:(UIView *)view;
@end