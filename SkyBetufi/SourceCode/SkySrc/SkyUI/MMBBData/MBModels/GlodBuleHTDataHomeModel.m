#import "GlodBuleHTDataHomeModel.h"
#import "GlodBuleHTHtmlLoadUtil.h"
@implementation GlodBuleHTDataHomeModel
- (void)waterSkyimageUrlFixWithWidth:(NSInteger)width {
    if (!_html_team_logo) {
        _html_team_logo = @"";
        if ([RX(@".svg$") isMatch:self.team_logo]) {
            _html_team_logo = [[GlodBuleHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:self.team_logo
                                                                        width:width];
        }
    }
}
@end
