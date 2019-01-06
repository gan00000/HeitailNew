#import "HBBJUnPasteTextField+Mixcode.h"
@implementation HBBJUnPasteTextField (Mixcode)
- (void)canPerformAction:(SEL)action withSender:(id)sender mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
