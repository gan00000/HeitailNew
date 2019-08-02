#import "SkyBallHetiRedHTNoCommentFooterView.h"
@implementation SkyBallHetiRedHTNoCommentFooterView
+ (instancetype)waterSkyfooterViewWithFrame:(CGRect)frame {
    SkyBallHetiRedHTNoCommentFooterView *footerView = kLoadXibWithName(NSStringFromClass([SkyBallHetiRedHTNoCommentFooterView class]));
    footerView.frame = frame;
    return footerView;
}
@end
