#import "JXDirectionPanGestureRecognizer.h"
static const NSInteger JXDirectionPanThreshold = 5;
@implementation JXDirectionPanGestureRecognizer {
    int _moveX;
    int _moveY;
}
@synthesize direction = _direction;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (self.direction != JXAnimatorDirectionNone) return;
    self.direction = [self determineDirectionIfNeeded:touches];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    _moveX = 0;
    _moveY = 0;
}
- (JXAnimatorDirection)determineDirectionIfNeeded:(NSSet *)touches {
    if (self.direction == JXAnimatorDirectionNone) {
        CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
        BOOL inDisableScope = CGRectContainsPoint(self.disableScope, nowPoint);
        if (inDisableScope) {
            return JXAnimatorDirectionNone;
        } else {
            CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
            _moveX += prevPoint.x - nowPoint.x;
            _moveY += prevPoint.y - nowPoint.y;
            if (abs(_moveX) > JXDirectionPanThreshold) {
                if (_moveX > 0) { 
                    return JXAnimatorDirectionLeft;
                } else { 
                    return JXAnimatorDirectionRight;
                }
            } else if (abs(_moveY) > JXDirectionPanThreshold) {
                if (_moveY > 0) { 
                    return JXAnimatorDirectionTop;
                } else { 
                    return JXAnimatorDirectionBottom;
                }
            }
        }
    }
    return self.direction;
}
- (void)reset {
    [super reset];
    _moveX = 0;
    _moveY = 0;
}
@end
