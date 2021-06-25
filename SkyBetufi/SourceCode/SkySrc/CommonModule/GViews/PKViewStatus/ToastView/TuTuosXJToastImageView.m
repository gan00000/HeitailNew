#import "TuTuosXJToastImageView.h"
@interface TuTuosXJToastImageView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation TuTuosXJToastImageView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
}
@end
