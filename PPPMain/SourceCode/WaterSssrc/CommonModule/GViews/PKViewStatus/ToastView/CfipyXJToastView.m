#import "CfipyXJToastView.h"
@interface CfipyXJToastView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation CfipyXJToastView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
