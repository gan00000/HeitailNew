#import "NSObject+nextresponderMixcode.h"
@implementation NSObject (nextresponderMixcode)
- (void)responder:(NSObject *)_s className:(NSString *)_c mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)cellResponder:(NSObject *)_s className:(NSString *)_c mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
