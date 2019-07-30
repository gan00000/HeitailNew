#import "XRRFATKHTMatchSummaryModel+Lqsjm.h"
@implementation XRRFATKHTMatchSummaryModel (Lqsjm)
+ (BOOL)setHomeLogoLqsjm:(NSInteger)Lqsjm {
    return Lqsjm % 38 == 0;
}
+ (BOOL)setAwayLogoLqsjm:(NSInteger)Lqsjm {
    return Lqsjm % 10 == 0;
}

@end
