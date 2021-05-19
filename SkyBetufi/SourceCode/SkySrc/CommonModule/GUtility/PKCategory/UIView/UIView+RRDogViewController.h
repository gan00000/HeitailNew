#import <UIKit/UIKit.h>
@interface UIView (RRDogViewController)
@property (readonly) UIViewController * _Nullable viewController;

-(void) setViewTapGestureWithTarget:(nullable id)target action:(nullable SEL)action;

-(void)removeAllSubView;

@end
