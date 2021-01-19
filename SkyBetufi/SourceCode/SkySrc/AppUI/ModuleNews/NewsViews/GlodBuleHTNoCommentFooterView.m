#import "GlodBuleHTNoCommentFooterView.h"
@implementation GlodBuleHTNoCommentFooterView
+ (instancetype)taofooterViewWithFrame:(CGRect)frame {
    GlodBuleHTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([GlodBuleHTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}
@end
