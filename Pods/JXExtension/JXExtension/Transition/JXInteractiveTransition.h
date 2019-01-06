#import <UIKit/UIKit.h>
#import "JXInteractiveDirection.h"
@class JXInteractiveTransition, JXInteractiveDirection;
typedef NS_ENUM(NSUInteger, JXInteractiveType) {
    JXInteractiveTypePresent = 0,
    JXInteractiveTypeDismiss,
};
typedef void(^JXInteractiveGestureDirectionBlock)(JXInteractiveDirection *direction);
@protocol JXInteractiveTransitionDelegate <NSObject>
@optional
- (void)jx_interactiveTransitionWillBegin:(JXInteractiveTransition *)interactiveTransition;
- (void)jx_interactiveTransition:(JXInteractiveTransition *)interactiveTransition isUpdating:(CGFloat)percent;
- (void)jx_interactiveTransitionWillBeginTimerAnimation:(JXInteractiveTransition *)interactiveTransition;
- (void)jx_interactiveTransition:(JXInteractiveTransition *)interactiveTransition willEndWithSuccessFlag:(BOOL)flag percent:(CGFloat)percent;
@end
@interface JXInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) CGRect disableScope; 
@property (nonatomic, assign, readonly) BOOL isInteractive; 
@property (nonatomic, assign) CGFloat minPersent; 
@property (nonatomic, assign) CGFloat panRatioBaseValue; 
@property (nonatomic, assign) BOOL timerEable; 
@property (nonatomic, assign) JXAnimatorDirection enadleDirection; 
@property (nonatomic, strong, readonly)JXInteractiveDirection *direction; 
@property (nonatomic, copy) JXInteractiveGestureDirectionBlock configBlock; 
@property (nonatomic, weak) id <JXInteractiveTransitionDelegate> delegate;
- (instancetype)initWithType:(JXInteractiveType)type;
- (void)addPanGestureForView:(UIView *)view;
@end
