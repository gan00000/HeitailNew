#import "BByasHTMatchHomeGroupHeaderView.h"
@interface BByasHTMatchHomeGroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *xxContentView;

@end
@implementation BByasHTMatchHomeGroupHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    if (isAppInView) {
        self.xxContentView.backgroundColor = UIColor.grayColor;
    }
}

- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}
@end
