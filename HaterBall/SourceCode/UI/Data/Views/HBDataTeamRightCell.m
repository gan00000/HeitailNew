#import "HBDataTeamRightCell.h"
@interface HBDataTeamRightCell ()
@property (weak, nonatomic) IBOutlet UILabel *ptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *fgattLabel;
@property (weak, nonatomic) IBOutlet UILabel *fgmadeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fg3pattLabel;
@property (weak, nonatomic) IBOutlet UILabel *fg3pmadeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftattLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftmadeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rebLabel;
@property (weak, nonatomic) IBOutlet UILabel *astLabel;
@property (weak, nonatomic) IBOutlet UILabel *stlLabel;
@property (weak, nonatomic) IBOutlet UILabel *blkLabel;
@property (weak, nonatomic) IBOutlet UILabel *foulsLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameTimesLabel;
@end
@implementation HBDataTeamRightCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)refreshWithTeamModel:(HBDataTeamRankModel *)teamModel row:(NSInteger)row {
    NSInteger matches = teamModel.matches.integerValue;
    if (matches > 0) {
        self.ptsLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.pts / matches];
        self.fgattLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.fgatt / matches];
        self.fgmadeRateLabel.text = @"0.0%";
        if (teamModel.fgatt > 0) {
            self.fgmadeRateLabel.text = [NSString stringWithFormat:@"%.1f%%", 100 * teamModel.fgmade / teamModel.fgatt];
        }
        self.fg3pattLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.fg3ptatt / matches];
        self.fg3pmadeRateLabel.text = @"0.0%";
        if (teamModel.fg3ptatt > 0) {
            self.fg3pmadeRateLabel.text = [NSString stringWithFormat:@"%.1f%%", 100 * teamModel.fg3ptmade / teamModel.fg3ptatt];
        }
        self.ftattLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.ftatt / matches];
        self.ftmadeRateLabel.text = @"0.0%";
        if (teamModel.ftatt > 0) {
            self.ftmadeRateLabel.text = [NSString stringWithFormat:@"%.1f%%", 100 * teamModel.ftmade / teamModel.ftatt];
        }
        self.rebLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.reb / matches];
        self.astLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.ast / matches];
        self.stlLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.stl / matches];
        self.blkLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.blk / matches];
        self.foulsLabel.text = [NSString stringWithFormat:@"%.1f", teamModel.fouls / matches];
        self.gameTimesLabel.text = teamModel.matches;
    } else {
        self.ptsLabel.text = @"0.0";
        self.fgattLabel.text = @"0.0";
        self.fgmadeRateLabel.text = @"0.0%";
        self.fg3pattLabel.text = @"0.0";
        self.fg3pmadeRateLabel.text = @"0.0%";
        self.ftattLabel.text = @"0.0";
        self.ftmadeRateLabel.text = @"0.0%";
        self.rebLabel.text = @"0.0";
        self.astLabel.text = @"0.0";
        self.stlLabel.text = @"0.0";
        self.blkLabel.text = @"0.0";
        self.foulsLabel.text = @"0.0";
        self.gameTimesLabel.text = @"0.0";
    }
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}
@end
