#import "HBMatchHomeModel+Mixcode.h"
@implementation HBMatchHomeModel (Mixcode)
+ (void)modelCustomPropertyMapperMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setHomeLogo:(NSString *)homeLogo mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setAwayLogo:(NSString *)awayLogo mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
