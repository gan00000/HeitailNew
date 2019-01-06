#import "UIScrollView+AllowScreenEdgePanGestureRecognizerMixcode.h"
@implementation UIScrollView (AllowScreenEdgePanGestureRecognizerMixcode)
- (void)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
