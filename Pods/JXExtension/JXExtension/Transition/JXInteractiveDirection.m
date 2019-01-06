#import "JXInteractiveDirection.h"
@implementation JXInteractiveDirection
+ (JXInteractiveDirection *)directionWithTo:(JXAnimatorDirection)to back:(JXAnimatorDirection)back {
    JXInteractiveDirection *direction = [[JXInteractiveDirection alloc] init];
    direction.toDirection = to;
    direction.backDirection = back;
    return direction;
}
@end
