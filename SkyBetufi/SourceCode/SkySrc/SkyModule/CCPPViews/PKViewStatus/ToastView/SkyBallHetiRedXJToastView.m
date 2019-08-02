#import "SkyBallHetiRedXJToastView.h"
@interface SkyBallHetiRedXJToastView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation SkyBallHetiRedXJToastView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
