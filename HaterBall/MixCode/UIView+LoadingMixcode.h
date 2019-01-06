#import <UIKit/UIKit.h>
#import "UIView+Loading.h"
#import "HBXJLoadingView.h"
#import "objc/runtime.h"
#import "Masonry.h"

@interface UIView (LoadingMixcode)
- (void)setLoadingView:(UIView *)loadingView mixcode:(NSString *)mixcode;
- (void)loadingViewMixcode:(NSString *)mixcode;
- (void)showLoadingViewMixcode:(NSString *)mixcode;
- (void)showLoadingViewWithEdge:(UIEdgeInsets)edge mixcode:(NSString *)mixcode;
- (void)hideLoadingViewMixcode:(NSString *)mixcode;

@end
