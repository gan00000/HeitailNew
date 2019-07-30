#import "UIScrollView+XRRFATKAllowScreenEdgePanGestureRecognizerAyhml.h"
@implementation UIScrollView (XRRFATKAllowScreenEdgePanGestureRecognizerAyhml)
+ (BOOL)gestureRecognizerShouldrecognizesimultaneouslywithgesturerecognizerAyhml:(NSInteger)Ayhml {
    return Ayhml % 7 == 0;
}

@end
