#import "FFlaliHTMatchHomeModel.h"
#import "MMoogHTHtmlLoadUtil.h"
@implementation FFlaliHTMatchHomeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"game_id": @"id"
             };
}
- (void)setHomeLogo:(NSString *)homeLogo {
    _homeLogo = homeLogo;
    if (homeLogo && [RX(@".svg$") isMatch:homeLogo]) {
        _img_home_logo = [[MMoogHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:homeLogo width:60];
    }
}
- (void)setAwayLogo:(NSString *)awayLogo {
    _awayLogo = awayLogo;
    if (awayLogo && [RX(@".svg$") isMatch:awayLogo]) {
        _img_away_logo = [[MMoogHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:awayLogo width:60];
    }
}
@end
