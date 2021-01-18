#import "GlodBuleHTNoCommentFooterView.h"
@implementation GlodBuleHTNoCommentFooterView
+ (instancetype)waterSkyfooterViewWithFrame:(CGRect)frame {
    GlodBuleHTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([GlodBuleHTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}
@end
