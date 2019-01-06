#import "HBBJHUDView.h"
@interface HBBJHUDView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;
@end
@implementation HBBJHUDView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.cornerRadius = 3;
    self.contentView.layer.shadowOffset = CGSizeMake(1, -2);
    self.contentView.layer.shadowRadius = 5;
    self.contentView.layer.shadowColor = RGBA_COLOR_HEX(0x666666).CGColor;
    self.contentView.layer.shadowOpacity = 0.5;
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    animation.duration = 2.0f;
    animation.repeatCount = HUGE_VAL;
    [self.progressImageView.layer addAnimation:animation forKey:@"HBBJHUDView"];
}
@end
