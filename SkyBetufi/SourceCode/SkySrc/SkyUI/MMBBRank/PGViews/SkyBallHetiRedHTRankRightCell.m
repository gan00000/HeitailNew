#import "SkyBallHetiRedHTRankRightCell.h"
@interface SkyBallHetiRedHTRankRightCell ()
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
@property (weak, nonatomic) IBOutlet UILabel *winRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *losePtsLabel;
@end
@implementation SkyBallHetiRedHTRankRightCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkyrefreshWithRankModel:(SkyBallHetiRedHTRankModel *)rankModel row:(NSInteger)row {
    self.winLabel.text = rankModel.win;
    self.loseLabel.text = rankModel.loss;
    self.winRateLabel.text = rankModel.winRate;
    self.homeLabel.text = rankModel.home_matches;
    self.awayLabel.text = rankModel.away_matches;
    self.areaLabel.text = rankModel.area_matches;
    self.ptsLabel.text = rankModel.avg_pts;
    self.losePtsLabel.text = rankModel.avg_against_pts;
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}
@end
