#import "SkyBallHetiRedHTDataHomeModel.h"
#import "SkyBallHetiRedHTHtmlLoadUtil.h"
@implementation SkyBallHetiRedHTDataHomeModel
- (void)waterSkyimageUrlFixWithWidth:(NSInteger)width {
    if (!_html_team_logo) {
        _html_team_logo = @"";
        if ([RX(@".svg$") isMatch:self.team_logo]) {
            _html_team_logo = [[SkyBallHetiRedHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:self.team_logo
                                                                        width:width];
        }
    }
}
@end
