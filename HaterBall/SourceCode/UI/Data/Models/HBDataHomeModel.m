#import "HBDataHomeModel.h"
#import "HBHtmlLoadUtil.h"
@implementation HBDataHomeModel
- (void)imageUrlFixWithWidth:(NSInteger)width {
    if (!_html_team_logo) {
        _html_team_logo = @"";
        if ([RX(@".svg$") isMatch:self.team_logo]) {
            _html_team_logo = [[HBHtmlLoadUtil sharedInstance] svgHtmlWithUrl:self.team_logo
                                                                        width:width];
        }
    }
}
@end
