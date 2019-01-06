#import <UIKit/UIKit.h>
#import "UIView+EmptyView.h"
#import "objc/runtime.h"
#import "HBXJEmptyView.h"
#import "Masonry.h"
#import "AFNetworkReachabilityManager.h"

@interface UIView (EmptyViewMixcode)
- (void)setEmptyView:(HBXJEmptyView *)emptyView mixcode:(NSString *)mixcode;
- (void)emptyViewMixcode:(NSString *)mixcode;
- (void)showEmptyViewMixcode:(NSString *)mixcode;
- (void)showEmptyViewWithEdge:(UIEdgeInsets)edge mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithTitle:(NSString *)title mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithTitle:(NSString *)title edge:(UIEdgeInsets)edge mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithTitle:(NSString *)title tapBlock:(dispatch_block_t)tapBlock mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithTitle:(NSString *)title tapBlock:(dispatch_block_t)tapBlock edge:(UIEdgeInsets)edge mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithImage:(UIImage *)image mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithImage:(UIImage *)image edge:(UIEdgeInsets)edge mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title edge:(UIEdgeInsets)edge mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title tapBlock:(dispatch_block_t)tapBlock mixcode:(NSString *)mixcode;
- (void)showEmptyViewWithImage:(UIImage *)image title:(NSString *)title tapBlock:(dispatch_block_t)tapBlock edge:(UIEdgeInsets)edge mixcode:(NSString *)mixcode;
- (void)updateEmptyViewColor:(UIColor *)bgColor mixcode:(NSString *)mixcode;
- (void)hideEmptyViewMixcode:(NSString *)mixcode;

@end
