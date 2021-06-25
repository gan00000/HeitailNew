#import "UITableView+KSasxHourseEstimatedHeight.h"
@implementation UITableView (HourseEstimatedHeight)
- (void)disableEstimatedHeight {
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
}
@end
