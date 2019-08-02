#import "SkyBallHetiRedHTMatchHomeGroupHeaderView.h"
@interface SkyBallHetiRedHTMatchHomeGroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation SkyBallHetiRedHTMatchHomeGroupHeaderView
- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}
@end
