#import <UIKit/UIKit.h>
#import "UIScrollView+AllowScreenEdgePanGestureRecognizer.h"

@interface UIScrollView (AllowScreenEdgePanGestureRecognizerMixcode)
- (void)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer mixcode:(NSString *)mixcode;

@end
