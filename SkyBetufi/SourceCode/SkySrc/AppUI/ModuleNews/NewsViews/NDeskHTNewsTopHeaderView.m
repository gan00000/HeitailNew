#import "NDeskHTNewsTopHeaderView.h"
@interface NDeskHTNewsTopHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation NDeskHTNewsTopHeaderView
- (void)taorefreshWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end
