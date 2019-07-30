#import "UITableView+XRRFATKEstimatedHeight.h"
@implementation UITableView (XRRFATKEstimatedHeight)
- (void)disableEstimatedHeight {
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
}
@end
