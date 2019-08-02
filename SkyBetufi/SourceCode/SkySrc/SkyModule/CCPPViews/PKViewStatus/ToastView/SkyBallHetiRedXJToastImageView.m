#import "SkyBallHetiRedXJToastImageView.h"
@interface SkyBallHetiRedXJToastImageView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation SkyBallHetiRedXJToastImageView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
