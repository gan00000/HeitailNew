#import "UITableView+SkyBallHetiRedEstimatedHeight.h"
@implementation UITableView (SkyBallHetiRedEstimatedHeight)
- (void)disableEstimatedHeight {
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
}
@end
