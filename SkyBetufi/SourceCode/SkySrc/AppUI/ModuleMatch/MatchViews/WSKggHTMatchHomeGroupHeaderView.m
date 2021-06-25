#import "WSKggHTMatchHomeGroupHeaderView.h"
@interface WSKggHTMatchHomeGroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *xxContentView;

@end
@implementation WSKggHTMatchHomeGroupHeaderView

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
