#import "HBXJToastImageView.h"
@interface HBXJToastImageView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation HBXJToastImageView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
