#import "UIScrollView+AllowScreenEdgePanGestureRecognizer.h"
@implementation UIScrollView (AllowScreenEdgePanGestureRecognizer)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return YES;
    } else {
        return  NO;
    }
}
@end
