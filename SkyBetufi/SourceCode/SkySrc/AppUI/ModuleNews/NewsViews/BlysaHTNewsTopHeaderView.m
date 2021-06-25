#import "BlysaHTNewsTopHeaderView.h"
@interface BlysaHTNewsTopHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation BlysaHTNewsTopHeaderView
- (void)taorefreshWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end
