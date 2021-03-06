#import "SkyBallHetiRedHTDataTeamLeftCell.h"
#import "UIImageView+HT.h"
@interface SkyBallHetiRedHTDataTeamLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamImageView;


@end
@implementation SkyBallHetiRedHTDataTeamLeftCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkyrefreshWithTeamModel:(SkyBallHetiRedHTDataTeamRankModel *)teamModel row:(NSInteger)row {
    self.orderLabel.text = [NSString stringWithFormat:@"%ld", row + 1];
    self.teamNameLabel.text = teamModel.teamName;
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    [self.teamImageView th_setImageWithURL:teamModel.team_logo placeholderImage:nil];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}
@end
