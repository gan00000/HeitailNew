#import "SkyBallHetiRedBJEmptyTableViewCell.h"
#import "UIView+SkyBallHetiRedEmptyView.h"
@implementation SkyBallHetiRedBJEmptyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
}
@end
