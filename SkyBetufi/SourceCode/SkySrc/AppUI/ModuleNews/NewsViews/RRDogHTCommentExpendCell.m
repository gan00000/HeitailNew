#import "RRDogHTCommentExpendCell.h"
@implementation RRDogHTCommentExpendCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)onExpendAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.onExpendChangeBlock) {
        self.onExpendChangeBlock(sender.selected);
    }
}
@end
