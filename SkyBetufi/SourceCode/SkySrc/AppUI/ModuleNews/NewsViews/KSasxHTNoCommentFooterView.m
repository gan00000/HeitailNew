#import "KSasxHTNoCommentFooterView.h"
@implementation KSasxHTNoCommentFooterView
+ (instancetype)taofooterViewWithFrame:(CGRect)frame {
    KSasxHTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([KSasxHTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}
@end
