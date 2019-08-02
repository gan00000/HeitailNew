#import "SkyBallHetiRedHTMeCenterItemsCell.h"
@implementation SkyBallHetiRedHTMeCenterItemsCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)onItemAction:(UIButton *)sender {
    if (![SkyBallHetiRedHTUserManager waterSky_isUserLogin]) {
        [SkyBallHetiRedHTUserManager waterSky_doUserLogin];
        return;
    }
    if (self.onItemTappedBlock) {
        self.onItemTappedBlock(sender.tag);
    }
}
@end
