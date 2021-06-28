#import "KSasxHTMatchDataRightCell.h"
@interface KSasxHTMatchDataRightCell ()
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
@implementation KSasxHTMatchDataRightCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taorefreshWithModel:(UUaksHTMatchDetailsModel *)model row:(NSInteger)row {
    
    CGFloat textSize = 14;
    CGFloat textLabelWitdh = 50;
    
    self.positionLabel.text = model.position;
    self.positionLabel.font =  [UIFont systemFontOfSize:textSize];
    self.positionLabel.hidden = YES;
    self.positionLabel.jx_width = textLabelWitdh;
    
    self.timeLabel.text = model.time;
    self.timeLabel.font =  [UIFont systemFontOfSize:textSize];
    self.timeLabel.jx_width = textLabelWitdh;
    
    self.ptsLabel.text = model.pts;
    self.ptsLabel.font =  [UIFont systemFontOfSize:textSize];
    self.ptsLabel.jx_width = textLabelWitdh;
    
    self.astLabel.text = model.ast;
    self.astLabel.font =  [UIFont systemFontOfSize:textSize];
    self.astLabel.jx_width = textLabelWitdh;
    
    self.rebLabel.text = model.reb;
    self.rebLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.fgmadeLabel.text = model.fgmade_show;
    self.fgmadeLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.fg3madeLabel.text = model.fg3ptmade_show;
    self.fg3madeLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.ftmageLabel.text = model.ftmade_show;
    self.ftmageLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.offrebLabel.text = model.offreb;
    self.offrebLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.defrebLabel.text = model.defreb;
    self.defrebLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.foulsLabel.text = model.fouls;
    self.foulsLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.stlLabel.text = model.stl;
    self.stlLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.blkagainstLabel.text = model.blkagainst;
    self.blkagainstLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.blkLabel.text = model.blk;
    self.blkLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.plusminusLabel.text = model.plusminus;
    self.plusminusLabel.font =  [UIFont systemFontOfSize:textSize];
    
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row > 4) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"eef0f4"];
    }
    self.line.hidden = NO;
//    if (row == 4) {
//        self.line.hidden = NO;
//    }
}
@end
