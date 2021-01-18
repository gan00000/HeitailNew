#import "GlodBuleXJToastImageView.h"
@interface GlodBuleXJToastImageView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation GlodBuleXJToastImageView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
