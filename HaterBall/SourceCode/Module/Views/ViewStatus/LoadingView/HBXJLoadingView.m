#import "HBXJLoadingView.h"
@interface HBXJLoadingView ()
@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;
@end
@implementation HBXJLoadingView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    animation.duration = 2.0f;
    animation.repeatCount = HUGE_VAL;
    [self.progressImageView.layer addAnimation:animation forKey:@"HBBJHUDView"];
}
@end
