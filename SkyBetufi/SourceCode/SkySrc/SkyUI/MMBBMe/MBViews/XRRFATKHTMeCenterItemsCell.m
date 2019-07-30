#import "XRRFATKHTMeCenterItemsCell.h"
@implementation XRRFATKHTMeCenterItemsCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)onItemAction:(UIButton *)sender {
    if (![XRRFATKHTUserManager skarg_isUserLogin]) {
        [XRRFATKHTUserManager skarg_doUserLogin];
        return;
    }
    if (self.onItemTappedBlock) {
        self.onItemTappedBlock(sender.tag);
    }
}
@end
