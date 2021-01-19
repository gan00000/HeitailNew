#import "GlodBuleXJToastView.h"
@interface GlodBuleXJToastView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation GlodBuleXJToastView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
