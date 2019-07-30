#import "XRRFATKHTLoginAlertView.h"
@interface XRRFATKHTLoginAlertView ()
@property (weak, nonatomic) IBOutlet UIView *safeBackView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewBottom;
@property (nonatomic, copy) void (^onPlatformButtonTapped)(HTLoginPlatform platform);
@end
@implementation XRRFATKHTLoginAlertView
+ (void)skargshowLoginAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block {
    XRRFATKHTLoginAlertView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.onPlatformButtonTapped = block;
    [alertView show];
}
+ (void)skargshowShareAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block {
    XRRFATKHTLoginAlertView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.titleLabel.text = @"分享至";
    alertView.onPlatformButtonTapped = block;
    [alertView show];
}
- (void)show {
    self.frame = kDRWindow.bounds;
    [kDRWindow addSubview:self];
    [UIView performWithoutAnimation:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.containerViewBottom.constant = - (self.containerViewHeight.constant + [UITabBar safeHeight]);
        [self layoutIfNeeded];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.containerViewBottom.constant = 0;
        [self layoutIfNeeded];
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containerViewBottom.constant = - (self.containerViewHeight.constant + [UITabBar safeHeight]);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    if (!CGRectContainsPoint(self.safeBackView.frame, loc)) {
        [self dismiss];
    }
}
- (IBAction)loginAction:(UIButton *)sender {
    if (self.onPlatformButtonTapped) {
        self.onPlatformButtonTapped(sender.tag);
    }
    [self dismiss];
}
@end
