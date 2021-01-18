#import "GlodBuleHTMeCenterItemsCell.h"
@implementation GlodBuleHTMeCenterItemsCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)onItemAction:(UIButton *)sender {
    if (![GlodBuleHTUserManager waterSky_isUserLogin]) {
        [GlodBuleHTUserManager waterSky_doUserLogin];
        return;
    }
    if (self.onItemTappedBlock) {
        self.onItemTappedBlock(sender.tag);
    }
}
@end
