#import "KSasxHTMatchSummaryModel.h"
#import "TuTuosHTHtmlLoadUtil.h"
@implementation KSasxHTMatchSummaryModel
- (void)setHomeLogo:(NSString *)homeLogo {
    _homeLogo = homeLogo;
    if (homeLogo && [RX(@".svg$") isMatch:homeLogo]) {
        _img_home_logo = [[TuTuosHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:homeLogo width:60];
    }
}
- (void)setAwayLogo:(NSString *)awayLogo {
    _awayLogo = awayLogo;
    if (awayLogo && [RX(@".svg$") isMatch:awayLogo]) {
        _img_away_logo = [[TuTuosHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:awayLogo width:60];
    }
}
@end
