#import "UUaksHTNewsTopHeaderView.h"
@interface UUaksHTNewsTopHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation UUaksHTNewsTopHeaderView
- (void)taorefreshWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end
