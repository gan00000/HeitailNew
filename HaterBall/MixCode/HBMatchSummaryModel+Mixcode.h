#import <Foundation/Foundation.h>
#import "HBMatchDetailsModel.h"
#import "HBMatchSummaryModel.h"
#import "HBHtmlLoadUtil.h"

@interface HBMatchSummaryModel (Mixcode)
- (void)setHomeLogo:(NSString *)homeLogo mixcode:(NSString *)mixcode;
- (void)setAwayLogo:(NSString *)awayLogo mixcode:(NSString *)mixcode;

@end
