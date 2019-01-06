#import "UITableView+EstimatedHeight.h"
@implementation UITableView (EstimatedHeight)
- (void)disableEstimatedHeight {
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
}
@end
