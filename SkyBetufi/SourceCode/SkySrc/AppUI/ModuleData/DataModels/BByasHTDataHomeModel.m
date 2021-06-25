#import "BByasHTDataHomeModel.h"
#import "TuTuosHTHtmlLoadUtil.h"
@implementation BByasHTDataHomeModel
- (void)taoimageUrlFixWithWidth:(NSInteger)width {
    if (!_html_team_logo) {
        _html_team_logo = @"";
        if ([RX(@".svg$") isMatch:self.team_logo]) {
            _html_team_logo = [[TuTuosHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:self.team_logo
                                                                        width:width];
        }
    }
}
@end