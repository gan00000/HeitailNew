#import "UIView+EmptyView.h"
#import "objc/runtime.h"
#import "HBXJEmptyView.h"
#import "Masonry.h"
#import "AFNetworkReachabilityManager.h"
static void * kEmptyViewKey;
@implementation UIView (EmptyView)
- (void)setEmptyView:(HBXJEmptyView *)emptyView {
    objc_setAssociatedObject(self, &kEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (HBXJEmptyView *)emptyView {
    return objc_getAssociatedObject(self, &kEmptyViewKey);
}
- (void)showEmptyView {
    [self showEmptyViewWithTitle:nil tapBlock:nil];
}
- (void)showEmptyViewWithEdge:(UIEdgeInsets)edge {
    [self showEmptyViewWithTitle:nil tapBlock:nil edge:edge];
}
- (void)showEmptyViewWithTitle:(NSString *)title {
    [self showEmptyViewWithTitle:title tapBlock:nil];
}
- (void)showEmptyViewWithTitle:(NSString *)title edge:(UIEdgeInsets)edge {
    [self showEmptyViewWithTitle:title tapBlock:nil edge:edge];
}
- (void)showEmptyViewWithTitle:(NSString *)title tapBlock:(dispatch_block_t)tapBlock {
    [self showEmptyViewWithTitle:title tapBlock:tapBlock edge:UIEdgeInsetsZero];
}
- (void)showEmptyViewWithTitle:(NSString *)title tapBlock:(dispatch_block_t)tapBlock edge:(UIEdgeInsets)edge {
    [self showEmptyViewWithImage:nil title:title tapBlock:tapBlock edge:edge];
}
#pragma mark - Image
- (void)showEmptyViewWithImage:(UIImage *)image {
    [self showEmptyViewWithImage:image title:nil tapBlock:nil edge:UIEdgeInsetsZero];
}
- (void)showEmptyViewWithImage:(UIImage *)image edge:(UIEdgeInsets)edge {
    [self showEmptyViewWithImage:image title:nil tapBlock:nil edge:edge];
}
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title {
    [self showEmptyViewWithImage:image title:title tapBlock:nil edge:UIEdgeInsetsZero];
}
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title edge:(UIEdgeInsets)edge {
    [self showEmptyViewWithImage:image title:title tapBlock:nil edge:edge];
}
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title tapBlock:(dispatch_block_t)tapBlock {
    [self showEmptyViewWithImage:image title:title tapBlock:tapBlock edge:UIEdgeInsetsZero];
}
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title tapBlock:(dispatch_block_t)tapBlock edge:(UIEdgeInsets)edge {
    [self hideEmptyView];
    HBXJEmptyView *emptyView = [[NSBundle mainBundle] loadNibNamed:@"HBXJEmptyView" owner:nil options:nil].firstObject;
    if (title.length > 0) {
        emptyView.contentLabel.text = title;
    }
    emptyView.contentTapBlock = tapBlock;
    if (image) {
        emptyView.imageView.image = image;
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        emptyView.imageView.image = [UIImage imageNamed:@"status_icon_no_network"];
        emptyView.contentLabel.text = @"網絡無法連接，請檢查網絡配置";
    }
    [self addSubview:emptyView];
    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(edge.left);
        make.right.mas_equalTo(edge.right);
        make.top.mas_equalTo(edge.top);
        make.bottom.mas_equalTo(edge.bottom);
        make.center.mas_equalTo(0);
    }];
    [self setEmptyView:emptyView];
}
- (void)updateEmptyViewColor:(UIColor *)bgColor {
    [self emptyView].backgroundColor = bgColor;
}
- (void)hideEmptyView {
    if ([self emptyView]) {
        [[self emptyView] removeFromSuperview];
        [self emptyView].contentTapBlock = nil;
        [self setEmptyView:nil];
    }
}
@end
