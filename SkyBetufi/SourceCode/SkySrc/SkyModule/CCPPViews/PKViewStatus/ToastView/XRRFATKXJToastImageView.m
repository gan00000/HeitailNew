#import "XRRFATKXJToastImageView.h"
@interface XRRFATKXJToastImageView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation XRRFATKXJToastImageView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
