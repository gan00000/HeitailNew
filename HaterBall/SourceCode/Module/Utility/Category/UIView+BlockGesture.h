#import <UIKit/UIKit.h>
typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);
@interface UIView (BlockGesture)
- (void)addTapActionWithBlock:(GestureActionBlock)block;
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;
@end
