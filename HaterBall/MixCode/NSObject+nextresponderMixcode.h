#import <UIKit/UIKit.h>
#import "NSObject+nextresponder.h"

@interface NSObject (nextresponderMixcode)
- (void)responder:(NSObject *)_s className:(NSString *)_c mixcode:(NSString *)mixcode;
- (void)cellResponder:(NSObject *)_s className:(NSString *)_c mixcode:(NSString *)mixcode;

@end
