#import "HBXJEmptyView+Mixcode.h"
@implementation HBXJEmptyView (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)contentTapActionMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
