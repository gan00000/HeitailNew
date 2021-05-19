#import "UITableView+HourseGlodBuleEstimatedHeight.h"
@implementation UITableView (HourseGlodBuleEstimatedHeight)
- (void)disableEstimatedHeight {
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
}
@end
