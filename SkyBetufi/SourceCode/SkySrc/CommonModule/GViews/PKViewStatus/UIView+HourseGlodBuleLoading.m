#import "UIView+HourseGlodBuleLoading.h"
#import "GGCatXJLoadingView.h"
#import "objc/runtime.h"
#import "Masonry.h"
static void * kLoadingViewKey;
@implementation UIView (HourseGlodBuleLoading)
- (void)setLoadingView:(UIView *)loadingView {
    objc_setAssociatedObject(self, &kLoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)loadingView {
    return objc_getAssociatedObject(self, &kLoadingViewKey);
}
- (void)showLoadingView {
    [self showLoadingViewWithEdge:UIEdgeInsetsZero];
}
- (void)showLoadingViewWithEdge:(UIEdgeInsets)edge {
    if ([self loadingView]) {
        [self bringSubviewToFront:[self loadingView]];
        return;
    }
    GGCatXJLoadingView *loadingView = [[NSBundle mainBundle] loadNibNamed:@"GGCatXJLoadingView" owner:nil options:nil].firstObject;
    [self addSubview:loadingView];
    [self bringSubviewToFront:loadingView];
    [self setLoadingView:loadingView];
    [loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(edge.left);
        make.right.mas_equalTo(edge.right);
        make.top.mas_equalTo(edge.top);
        make.bottom.mas_equalTo(edge.bottom);
        make.center.mas_equalTo(0);
    }];
}
- (void)hideLoadingView {
    if ([self loadingView]) {
        [[self loadingView] removeFromSuperview];
        [self setLoadingView:nil];
    }
}
@end
