#import "SkyBallHetiRedHTRankLeftCell.h"
#import "UIImageView+HT.h"
#import "UIColor+Hex.h"
@interface SkyBallHetiRedHTRankLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *shengfuLabel;
@property (weak, nonatomic) IBOutlet UILabel *shengchaLabel;
@property (weak, nonatomic) IBOutlet UILabel *shenglvLabel;
@property (weak, nonatomic) IBOutlet UILabel *lianshengfuLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;

@end
@implementation SkyBallHetiRedHTRankLeftCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkyrefreshWithRankModel:(SkyBallHetiRedHTRankModel *)rankModel row:(NSInteger)row {
   
    if (row+1 <= 8) {
        self.rankLabel.textColor = [UIColor colorWithHexString:@"fd7f23"];
        self.rankLabel.font = [UIFont boldSystemFontOfSize:12];
    } else {
         self.rankLabel.textColor = [UIColor blackColor];
        self.rankLabel.font = [UIFont systemFontOfSize:12];
    }
     self.rankLabel.text = [NSString stringWithFormat:@"%ld", row+1];
    [self.teamImageView th_setImageWithURL:rankModel.team_logo placeholderImage:nil];
    self.teamNameLabel.text = rankModel.teamName;
    self.shengfuLabel.text = [NSString stringWithFormat:@"%@-%@", rankModel.win,rankModel.loss];
    self.shenglvLabel.text = rankModel.winRate;
    self.shengchaLabel.text = rankModel.gamesBack;
    self.lianshengfuLabel.text = rankModel.streakDescription;
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
//        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}
@end
