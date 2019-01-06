#import <UIKit/UIKit.h>
#import "UIView+Toast.h"
#import "HBXJToastView.h"
#import "HBXJToastImageView.h"
#import "Masonry.h"

@interface UIView (ToastMixcode)
- (void)showToast:(NSString *)toast duration:(CGFloat)duration mixcode:(NSString *)mixcode;
- (void)showToast:(NSString *)toast mixcode:(NSString *)mixcode;
- (void)showToast:(NSString *)toast icon:(UIImage *)icon mixcode:(NSString *)mixcode;
- (void)showToast:(NSString *)toast icon:(UIImage *)icon duration:(CGFloat)duration mixcode:(NSString *)mixcode;

@end
