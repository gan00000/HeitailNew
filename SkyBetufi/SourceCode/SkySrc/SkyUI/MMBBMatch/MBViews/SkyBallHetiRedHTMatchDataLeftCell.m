#import "SkyBallHetiRedHTMatchDataLeftCell.h"
@interface SkyBallHetiRedHTMatchDataLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *line;
@end
@implementation SkyBallHetiRedHTMatchDataLeftCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)waterSkyrefreshWithName:(NSString *)name row:(NSInteger)row {
    self.nameLabel.text = name;
    self.nameLabel.font =  [UIFont boldSystemFontOfSize:14];
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
