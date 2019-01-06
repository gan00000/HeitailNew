#import <UIKit/UIKit.h>
#import "UIView+BlockGesture.h"
#import <objc/runtime.h>

@interface UIView (BlockGestureMixcode)
- (void)addTapActionWithBlock:(GestureActionBlock)block mixcode:(NSString *)mixcode;
- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture mixcode:(NSString *)mixcode;
- (void)addLongPressActionWithBlock:(GestureActionBlock)block mixcode:(NSString *)mixcode;
- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture mixcode:(NSString *)mixcode;

@end
