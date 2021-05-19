#import "PXFunBJEmptyTableViewCell.h"
#import "UIView+PXFunEmptyView.h"
@implementation PXFunBJEmptyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
}
@end
