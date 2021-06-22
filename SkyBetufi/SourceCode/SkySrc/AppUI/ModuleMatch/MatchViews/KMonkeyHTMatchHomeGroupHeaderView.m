#import "KMonkeyHTMatchHomeGroupHeaderView.h"
@interface KMonkeyHTMatchHomeGroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *xxContentView;

@end
@implementation KMonkeyHTMatchHomeGroupHeaderView

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
