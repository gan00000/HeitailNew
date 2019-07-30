#import "XRRFATKHTDataHomeModel.h"
#import "XRRFATKHTHtmlLoadUtil.h"
@implementation XRRFATKHTDataHomeModel
- (void)skargimageUrlFixWithWidth:(NSInteger)width {
    if (!_html_team_logo) {
        _html_team_logo = @"";
        if ([RX(@".svg$") isMatch:self.team_logo]) {
            _html_team_logo = [[XRRFATKHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:self.team_logo
                                                                        width:width];
        }
    }
}
@end
