#import <Foundation/Foundation.h>
#import "HBMatchHomeModel.h"
#import "HBHtmlLoadUtil.h"

@interface HBMatchHomeModel (Mixcode)
+ (void)modelCustomPropertyMapperMixcode:(NSString *)mixcode;
- (void)setHomeLogo:(NSString *)homeLogo mixcode:(NSString *)mixcode;
- (void)setAwayLogo:(NSString *)awayLogo mixcode:(NSString *)mixcode;

@end
