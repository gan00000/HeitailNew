#import "GlodBuleHTNewsTopHeaderView.h"
@interface GlodBuleHTNewsTopHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation GlodBuleHTNewsTopHeaderView
- (void)waterSkyrefreshWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end
