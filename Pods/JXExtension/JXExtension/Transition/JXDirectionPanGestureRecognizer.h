#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "JXTransitionConstant.h"
@interface JXDirectionPanGestureRecognizer : UIPanGestureRecognizer
@property (nonatomic, assign) JXAnimatorDirection direction; 
@property (nonatomic, assign) CGRect disableScope; 
@end
