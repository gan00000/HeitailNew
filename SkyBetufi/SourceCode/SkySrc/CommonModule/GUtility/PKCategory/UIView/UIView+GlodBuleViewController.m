#import "UIView+GlodBuleViewController.h"
@implementation UIView (SkyBallHetiRedViewController)
- (UIViewController *)viewController
{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    return nil;
}

-(void) setViewTapGestureWithTarget:(nullable id)target action:(nullable SEL)action{
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGes];

}
@end
