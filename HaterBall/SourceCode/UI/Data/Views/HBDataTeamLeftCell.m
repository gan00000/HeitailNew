#import "HBDataTeamLeftCell.h"
@interface HBDataTeamLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@end
@implementation HBDataTeamLeftCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)refreshWithTeamModel:(HBDataTeamRankModel *)teamModel row:(NSInteger)row {
    self.orderLabel.text = [NSString stringWithFormat:@"%ld", row + 1];
    self.teamNameLabel.text = teamModel.teamName;
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}
@end
