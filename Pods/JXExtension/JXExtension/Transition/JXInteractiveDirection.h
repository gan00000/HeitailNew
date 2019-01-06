#import <Foundation/Foundation.h>
#import "JXTransitionConstant.h"
@interface JXInteractiveDirection : NSObject
@property (nonatomic, assign) JXAnimatorDirection toDirection; 
@property (nonatomic, assign) JXAnimatorDirection backDirection; 
+ (JXInteractiveDirection *)directionWithTo:(JXAnimatorDirection)to back:(JXAnimatorDirection)back;
@end
