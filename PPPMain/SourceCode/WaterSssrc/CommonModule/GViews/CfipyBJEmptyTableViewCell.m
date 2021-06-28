#import "CfipyBJEmptyTableViewCell.h"
#import "UIView+CfipyEmptyView.h"
@implementation CfipyBJEmptyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
}
@end
