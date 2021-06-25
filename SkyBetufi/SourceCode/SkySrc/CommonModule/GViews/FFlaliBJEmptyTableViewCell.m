#import "FFlaliBJEmptyTableViewCell.h"
#import "UIView+BByasPXFunEmptyView.h"
@implementation FFlaliBJEmptyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
}
@end
