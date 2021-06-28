#import "UITableView+NSNiceEstimatedHeight.h"
@implementation UITableView (NSNiceEstimatedHeight)
- (void)disableEstimatedHeight {
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
}
@end
