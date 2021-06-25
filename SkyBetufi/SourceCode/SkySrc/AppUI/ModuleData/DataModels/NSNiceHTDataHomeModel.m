#import "NSNiceHTDataHomeModel.h"
#import "MMoogHTHtmlLoadUtil.h"
@implementation NSNiceHTDataHomeModel
- (void)taoimageUrlFixWithWidth:(NSInteger)width {
    if (!_html_team_logo) {
        _html_team_logo = @"";
        if ([RX(@".svg$") isMatch:self.team_logo]) {
            _html_team_logo = [[MMoogHTHtmlLoadUtil sharedInstance] svgHtmlWithUrl:self.team_logo
                                                                        width:width];
        }
    }
}
@end
