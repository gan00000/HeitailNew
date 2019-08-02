#import "SkyBallHetiRedHTNewsTopHeaderView.h"
@interface SkyBallHetiRedHTNewsTopHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation SkyBallHetiRedHTNewsTopHeaderView
- (void)waterSkyrefreshWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end
