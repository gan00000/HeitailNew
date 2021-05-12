#import "KMonkeyHTLeftMeCenterItemsCell.h"
@implementation KMonkeyHTLeftMeCenterItemsCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)onItemAction:(UIButton *)sender {
    if (![MMTodayHTUserManager tao_isUserLogin]) {
        [MMTodayHTUserManager tao_doUserLogin];
        return;
    }
    if (self.onItemTappedBlock) {
        self.onItemTappedBlock(sender.tag);
    }
}
@end
