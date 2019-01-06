#import "HBBJEmptyTableViewCell.h"
#import "UIView+EmptyView.h"
@implementation HBBJEmptyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
}
@end
