#import <UIKit/UIKit.h>
@interface UIView (BByasViewController)
@property (readonly) UIViewController * _Nullable viewController;

-(void) setViewTapGestureWithTarget:(nullable id)target action:(nullable SEL)action;

-(void)removeAllSubView;

@end