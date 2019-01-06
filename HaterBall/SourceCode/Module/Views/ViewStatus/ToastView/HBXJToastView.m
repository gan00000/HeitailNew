#import "HBXJToastView.h"
@interface HBXJToastView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation HBXJToastView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
