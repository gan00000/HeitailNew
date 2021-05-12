#import "KMonkeyHTMatchHomeGroupHeaderView.h"
@interface KMonkeyHTMatchHomeGroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation KMonkeyHTMatchHomeGroupHeaderView
- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}
@end
