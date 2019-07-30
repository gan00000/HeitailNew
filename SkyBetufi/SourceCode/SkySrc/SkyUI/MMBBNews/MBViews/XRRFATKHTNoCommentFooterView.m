#import "XRRFATKHTNoCommentFooterView.h"
@implementation XRRFATKHTNoCommentFooterView
+ (instancetype)skargfooterViewWithFrame:(CGRect)frame {
    XRRFATKHTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([XRRFATKHTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}
@end
