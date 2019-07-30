#import "XRRFATKHTMatchHomeModel.h"
#import "XRRFATKHTHtmlLoadUtil.h"
@implementation XRRFATKHTMatchHomeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"game_id": @"id"
             };
}
- (void)setHomeLogo:(NSString *)homeLogo {
    _homeLogo = homeLogo;
    if ([RX(@".svg$") isMatch:homeLogo]) {
        _img_home_logo = [[XRRFATKHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:homeLogo width:60];
    }
}
- (void)setAwayLogo:(NSString *)awayLogo {
    _awayLogo = awayLogo;
    if ([RX(@".svg$") isMatch:awayLogo]) {
        _img_away_logo = [[XRRFATKHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:awayLogo width:60];
    }
}
@end
