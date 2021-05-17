#import "PXFunHTDataHomeHeaderCell.h"
@interface PXFunHTDataHomeHeaderCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@end
@implementation PXFunHTDataHomeHeaderCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.arrowImageView.image = [self.arrowImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end