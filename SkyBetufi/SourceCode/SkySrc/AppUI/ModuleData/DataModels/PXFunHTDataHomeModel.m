#import "PXFunHTDataHomeModel.h"
#import "MMTodayHTHtmlLoadUtil.h"
@implementation PXFunHTDataHomeModel
- (void)taoimageUrlFixWithWidth:(NSInteger)width {
    if (!_html_team_logo) {
        _html_team_logo = @"";
        if ([RX(@".svg$") isMatch:self.team_logo]) {
            _html_team_logo = [[MMTodayHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:self.team_logo
                                                                        width:width];
        }
    }
}
@end
