#import "HBMatchHomeGroupHeaderView.h"
@interface HBMatchHomeGroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation HBMatchHomeGroupHeaderView
- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}
@end
