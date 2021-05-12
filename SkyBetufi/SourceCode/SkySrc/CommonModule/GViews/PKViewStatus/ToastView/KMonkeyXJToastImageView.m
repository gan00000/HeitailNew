#import "KMonkeyXJToastImageView.h"
@interface KMonkeyXJToastImageView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation KMonkeyXJToastImageView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
