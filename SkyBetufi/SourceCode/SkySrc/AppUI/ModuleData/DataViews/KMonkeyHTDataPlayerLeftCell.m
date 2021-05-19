#import "KMonkeyHTDataPlayerLeftCell.h"
#import "UIImageView+PXFunHT.h"
@interface KMonkeyHTDataPlayerLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *oderLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;


@end
@implementation KMonkeyHTDataPlayerLeftCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)taorefreshWithPlayerModel:(NDeskHTDataPlayerRankModel *)playerModel row:(NSInteger)row {
    self.oderLabel.text = [NSString stringWithFormat:@"%ld", row + 1];
    self.nameLabel.text = playerModel.name;
    [self.playerImageView th_setImageWithURL:playerModel.officialImagesrc placeholderImage:nil];
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}
@end
