#import <UIKit/UIKit.h>
@interface UIView (Toast)
- (void)showToast:(NSString *)toast;
- (void)showToast:(NSString *)toast duration:(CGFloat)duration;
- (void)showToast:(NSString *)toast icon:(UIImage *)icon;
- (void)showToast:(NSString *)toast icon:(UIImage *)icon duration:(CGFloat)duration;
@end
