#import "UIView+SkyBallHetiRedToast.h"
#import "SkyBallHetiRedXJToastView.h"
#import "SkyBallHetiRedXJToastImageView.h"
#import "Masonry.h"
@implementation UIView (SkyBallHetiRedToast)
- (void)showToast:(NSString *)toast duration:(CGFloat)duration {
    __block SkyBallHetiRedXJToastView *toastView = [[NSBundle mainBundle] loadNibNamed:@"SkyBallHetiRedXJToastView" owner:nil options:nil].firstObject;
    toastView.toastLabel.text = toast;
    toastView.alpha = 0;
    [self addSubview:toastView];
    [toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.centerY.mas_equalTo(-50);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        toastView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:duration options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            toastView.alpha = 0;
        } completion:^(BOOL finished) {
            [toastView removeFromSuperview];
            toastView = nil;
        }];
    }];
}
- (void)showToast:(NSString *)toast {
    [self showToast:toast duration:1];
}
- (void)showToast:(NSString *)toast icon:(UIImage *)icon {
    [self showToast:toast icon:icon duration:1];
}
- (void)showToast:(NSString *)toast icon:(UIImage *)icon duration:(CGFloat)duration {
    __block SkyBallHetiRedXJToastImageView *toastView = [[NSBundle mainBundle] loadNibNamed:@"SkyBallHetiRedXJToastImageView" owner:nil options:nil].firstObject;
    toastView.toastLabel.text = toast;
    toastView.iconImageView.image = icon;
    toastView.alpha = 0;
    [self addSubview:toastView];
    [toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        toastView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:duration options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            toastView.alpha = 0;
        } completion:^(BOOL finished) {
            [toastView removeFromSuperview];
            toastView = nil;
        }];
    }];
}
@end
