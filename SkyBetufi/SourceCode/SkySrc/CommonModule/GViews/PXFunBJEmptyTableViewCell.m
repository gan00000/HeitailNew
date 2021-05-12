#import "PXFunBJEmptyTableViewCell.h"
#import "UIView+PXFunGlodBuleEmptyView.h"
@implementation PXFunBJEmptyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
}
@end
