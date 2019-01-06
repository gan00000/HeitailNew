#import <Foundation/Foundation.h>
@interface NSInvocation (BlocksKit)
+ (NSInvocation *)bk_invocationWithTarget:(id)target block:(void (^)(id target))block;
@end
