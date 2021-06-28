#import "UUaksHTMeCenterItemsCell.h"
@implementation UUaksHTMeCenterItemsCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)onItemAction:(UIButton *)sender {
    if (![TuTuosHTUserManager tao_isUserLogin]) {
        [TuTuosHTUserManager tao_doUserLogin];
        return;
    }
    if (self.onItemTappedBlock) {
        self.onItemTappedBlock(sender.tag);
    }
}
@end
