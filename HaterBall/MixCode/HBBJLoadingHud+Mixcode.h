#import <Foundation/Foundation.h>
#import "HBBJLoadingHud.h"
#import "MBProgressHUD.h"
#import "HBBJHUDView.h"

@interface HBBJLoadingHud (Mixcode)
+ (void)showHUDInView:(UIView *)view mixcode:(NSString *)mixcode;
+ (void)showHUDWithText:(NSString *)text inView:(UIView *)view mixcode:(NSString *)mixcode;
+ (void)hideHUDInView:(UIView *)view mixcode:(NSString *)mixcode;

@end
