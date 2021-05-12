#import "RRDogHTNoCommentFooterView.h"
@implementation RRDogHTNoCommentFooterView
+ (instancetype)taofooterViewWithFrame:(CGRect)frame {
    RRDogHTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([RRDogHTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}
@end
