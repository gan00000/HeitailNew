#import "XRRFATKHTNewsTopHeaderView.h"
@interface XRRFATKHTNewsTopHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation XRRFATKHTNewsTopHeaderView
- (void)skargrefreshWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end
