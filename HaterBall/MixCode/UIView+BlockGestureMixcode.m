#import "UIView+BlockGestureMixcode.h"
@implementation UIView (BlockGestureMixcode)
- (void)addTapActionWithBlock:(GestureActionBlock)block mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)addLongPressActionWithBlock:(GestureActionBlock)block mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
