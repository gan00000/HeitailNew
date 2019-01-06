#import "HBRankLeftCell.h"
@interface HBRankLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@end
@implementation HBRankLeftCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)refreshWithRankModel:(HBRankModel *)rankModel row:(NSInteger)row {
    self.rankLabel.text = [NSString stringWithFormat:@"%ld", row+1];
    self.teamNameLabel.text = rankModel.teamName;
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}
@end
