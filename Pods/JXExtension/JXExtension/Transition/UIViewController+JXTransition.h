#import <UIKit/UIKit.h>
#import "JXTransitionConstant.h"
#import "JXTransitionAnimator.h"
@interface UIViewController (JXTransition)
- (void)jx_presentViewController:(UIViewController *)viewController animator:(JXTransitionAnimator *)animator completion:(void (^)(void))completion;
- (void)jx_registerToInteractiveTransitionWithDirection:(JXAnimatorDirection)direction minPersent:(CGFloat)minPersent transitonBlock:(JXInteractiveGestureDirectionBlock)transitonBlock;
- (void)jx_registerBackInteractiveTransitionWithDirection:(JXAnimatorDirection)direction minPersent:(CGFloat)minPersent transitonBlock:(JXInteractiveGestureDirectionBlock)transitonBlock;
@end
