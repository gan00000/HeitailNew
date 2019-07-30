#import "XRRFATKHTMatchHomeGroupHeaderView.h"
@interface XRRFATKHTMatchHomeGroupHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation XRRFATKHTMatchHomeGroupHeaderView
- (void)setName:(NSString *)name {
    self.nameLabel.text = name;
}
@end
