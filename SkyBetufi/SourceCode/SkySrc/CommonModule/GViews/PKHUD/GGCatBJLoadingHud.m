#import "GGCatBJLoadingHud.h"
#import "MBProgressHUD.h"
#import "PXFunBJHUDView.h"
@implementation GGCatBJLoadingHud
+ (void)showHUDInView:(UIView *)view {
    [self hideHUDInView:view];
    PXFunBJHUDView *customView = [[NSBundle mainBundle] loadNibNamed:@"PXFunBJHUDView" owner:nil options:nil].firstObject;
    customView.frame = view.bounds;
    customView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [view addSubview:customView];
    [view bringSubviewToFront:customView];
    customView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        customView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
+ (void)showHUDWithText:(NSString *)text inView:(UIView *)view {
    [self hideHUDInView:view];
    PXFunBJHUDView *customView = [[NSBundle mainBundle] loadNibNamed:@"PXFunBJHUDView" owner:nil options:nil].firstObject;
    customView.frame = view.bounds;
    customView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [view addSubview:customView];
    [view bringSubviewToFront:customView];
    customView.loadingLabel.text = text;
    customView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        customView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
+ (void)hideHUDInView:(UIView *)view {
    for (UIView *sv in view.subviews) {
        if ([sv isKindOfClass:[PXFunBJHUDView class]]) {
            [UIView animateWithDuration:0.3 animations:^{
                sv.alpha = 0;
            } completion:^(BOOL finished) {
                [sv removeFromSuperview];
            }];
            break;
        }
    }
}
@end