#import "HBDataPlayerRightCell.h"
@interface HBDataPlayerRightCell ()
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *fgattLabel;
@property (weak, nonatomic) IBOutlet UILabel *fgmadeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fg3gattLabel;
@property (weak, nonatomic) IBOutlet UILabel *fg3gmadeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftattLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftmadeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rebLabel;
@property (weak, nonatomic) IBOutlet UILabel *offrebLabel;
@property (weak, nonatomic) IBOutlet UILabel *defrebLabel;
@property (weak, nonatomic) IBOutlet UILabel *astLabel;
@property (weak, nonatomic) IBOutlet UILabel *stlLabel;
@property (weak, nonatomic) IBOutlet UILabel *blkLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnoverLabel;
@property (weak, nonatomic) IBOutlet UILabel *foulsLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
@implementation HBDataPlayerRightCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)refreshWithPlayerModel:(HBDataPlayerRankModel *)playerModel row:(NSInteger)row {
    self.teamLabel.text = playerModel.teamName;
    NSInteger matches = playerModel.matches.integerValue;
    if (matches > 0) {
        self.ptsLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.pts / matches];
        self.fgattLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.fgatt / matches];
        self.fgmadeRateLabel.text = @"0.0%";
        if (playerModel.fgatt > 0) {
            self.fgmadeRateLabel.text = [NSString stringWithFormat:@"%.1f%%", 100 * playerModel.fgmade / playerModel.fgatt];
        }
        self.fg3gattLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.fg3ptatt / matches];
        self.fg3gmadeRateLabel.text = @"0.0%";
        if (playerModel.fg3ptatt > 0) {
            self.fg3gmadeRateLabel.text = [NSString stringWithFormat:@"%.1f%%", 100 * playerModel.fg3ptmade / playerModel.fg3ptatt];
        }
        self.ftattLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.ftatt / matches];
        self.ftmadeRateLabel.text = @"0.0%";
        if (playerModel.ftatt > 0) {
            self.ftmadeRateLabel.text = [NSString stringWithFormat:@"%.1f%%", 100 * playerModel.ftmade / playerModel.ftatt];
        }
        self.rebLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.reb / matches];
        self.offrebLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.offreb / matches];
        self.defrebLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.defreb / matches];
        self.astLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.ast / matches];
        self.stlLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.stl / matches];
        self.blkLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.blk / matches];
        self.turnoverLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.turnover / matches];
        self.foulsLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.fouls / matches];
        self.gameTimesLabel.text = playerModel.matches;
        self.timeLabel.text = [NSString stringWithFormat:@"%.1f", playerModel.minseconds / 60 / matches];
    } else {
        self.ptsLabel.text = @"0.0";
        self.fgattLabel.text = @"0.0";
        self.fgmadeRateLabel.text = @"0.0%";
        self.fg3gattLabel.text = @"0.0";
        self.fg3gmadeRateLabel.text = @"0.0%";
        self.ftattLabel.text = @"0.0";
        self.ftmadeRateLabel.text = @"0.0%";
        self.rebLabel.text = @"0.0";
        self.offrebLabel.text = @"0.0";
        self.defrebLabel.text = @"0.0";
        self.astLabel.text = @"0.0";
        self.stlLabel.text = @"0.0";
        self.blkLabel.text = @"0.0";
        self.turnoverLabel.text = @"0.0";
        self.foulsLabel.text = @"0.0";
        self.gameTimesLabel.text = @"0.0";
        self.timeLabel.text = @"0.0";
    }
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}
@end
