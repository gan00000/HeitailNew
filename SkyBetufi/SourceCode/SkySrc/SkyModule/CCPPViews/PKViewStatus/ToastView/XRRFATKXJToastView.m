#import "XRRFATKXJToastView.h"
@interface XRRFATKXJToastView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation XRRFATKXJToastView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
