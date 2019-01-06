#import <Foundation/Foundation.h>
typedef void(^JXTransitionAnimationConfig)(id<UIViewControllerContextTransitioning> transitionContext);
@interface JXTransitionObject : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initWithDuration:(NSTimeInterval)duration animationBlock:(void(^)(id<UIViewControllerContextTransitioning> transitionContext))config;;
@end
