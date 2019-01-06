#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JXInteractiveTransition.h"
@interface JXTransitionAnimator : NSObject <UIViewControllerTransitioningDelegate, JXInteractiveTransitionDelegate>
@property (nonatomic, assign) NSTimeInterval toDuration;
@property (nonatomic, assign) NSTimeInterval backDuration;
@property (nonatomic, strong) JXInteractiveTransition *toInteractive;
@property (nonatomic, strong) JXInteractiveTransition *backInteractive;
@property (nonatomic, copy) UIPresentationController *(^presentationControllerBlock)(UIViewController *presented, UIViewController *presenting);
- (void)jx_setToAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)jx_setBackAnimation:(id<UIViewControllerContextTransitioning>)transitionContext;
@end
