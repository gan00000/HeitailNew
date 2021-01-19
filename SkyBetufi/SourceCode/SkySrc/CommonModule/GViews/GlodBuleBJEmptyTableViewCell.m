#import "GlodBuleBJEmptyTableViewCell.h"
#import "UIView+GlodBuleEmptyView.h"
@implementation GlodBuleBJEmptyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
}
@end
