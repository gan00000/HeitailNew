#import "XRRFATKBJEmptyTableViewCell.h"
#import "UIView+XRRFATKEmptyView.h"
@implementation XRRFATKBJEmptyTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
}
@end
