#import "UUaksXJToastView.h"
@interface UUaksXJToastView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation UUaksXJToastView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
