#import "GlodBuleHTMatchHomeGroupHeaderView.h"
@interface GlodBuleHTMatchHomeGroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation GlodBuleHTMatchHomeGroupHeaderView
- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}
@end
