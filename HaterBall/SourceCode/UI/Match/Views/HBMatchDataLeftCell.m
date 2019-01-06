#import "HBMatchDataLeftCell.h"
@interface HBMatchDataLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@end
@implementation HBMatchDataLeftCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)refreshWithName:(NSString *)name row:(NSInteger)row {
    self.nameLabel.text = name;
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
    self.line.hidden = YES;
    if (row == 4) {
        self.line.hidden = NO;
    }
}
@end
