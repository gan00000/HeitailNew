#import "YYPackageXJToastView.h"
@interface YYPackageXJToastView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation YYPackageXJToastView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
