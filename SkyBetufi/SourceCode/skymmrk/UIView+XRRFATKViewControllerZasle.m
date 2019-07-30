#import "UIView+XRRFATKViewControllerZasle.h"
@implementation UIView (XRRFATKViewControllerZasle)
+ (BOOL)viewControllerZasle:(NSInteger)Zasle {
    return Zasle % 17 == 0;
}

@end
