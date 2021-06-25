#import "BlysaXJToastImageView.h"
@interface BlysaXJToastImageView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation BlysaXJToastImageView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
