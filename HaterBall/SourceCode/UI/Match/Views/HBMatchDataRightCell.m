#import "HBMatchDataRightCell.h"
@interface HBMatchDataRightCell ()
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsLabel;
@property (weak, nonatomic) IBOutlet UILabel *astLabel;
@property (weak, nonatomic) IBOutlet UILabel *rebLabel;
@property (weak, nonatomic) IBOutlet UILabel *fgmadeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fg3madeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftmageLabel;
@property (weak, nonatomic) IBOutlet UILabel *offrebLabel;
@property (weak, nonatomic) IBOutlet UILabel *defrebLabel;
@property (weak, nonatomic) IBOutlet UILabel *foulsLabel;
@property (weak, nonatomic) IBOutlet UILabel *stlLabel;
@property (weak, nonatomic) IBOutlet UILabel *blkagainstLabel;
@property (weak, nonatomic) IBOutlet UILabel *blkLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusminusLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@end
@implementation HBMatchDataRightCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)refreshWithModel:(HBMatchDetailsModel *)model row:(NSInteger)row {
    self.positionLabel.text = model.position;
    self.timeLabel.text = model.time;
    self.ptsLabel.text = model.pts;
    self.astLabel.text = model.ast;
    self.rebLabel.text = model.reb;
    self.fgmadeLabel.text = model.fgmade_show;
    self.fg3madeLabel.text = model.fg3ptmade_show;
    self.ftmageLabel.text = model.ftmade_show;
    self.offrebLabel.text = model.offreb;
    self.defrebLabel.text = model.defreb;
    self.foulsLabel.text = model.fouls;
    self.stlLabel.text = model.stl;
    self.blkagainstLabel.text = model.blkagainst;
    self.blkLabel.text = model.blk;
    self.plusminusLabel.text = model.plusminus;
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
