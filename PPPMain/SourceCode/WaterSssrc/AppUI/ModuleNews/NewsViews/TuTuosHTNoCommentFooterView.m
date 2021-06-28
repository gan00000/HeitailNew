#import "TuTuosHTNoCommentFooterView.h"
@implementation TuTuosHTNoCommentFooterView
+ (instancetype)taofooterViewWithFrame:(CGRect)frame {
    TuTuosHTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([TuTuosHTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}
@end
