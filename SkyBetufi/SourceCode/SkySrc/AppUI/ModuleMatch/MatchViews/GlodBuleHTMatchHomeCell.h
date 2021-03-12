#import <UIKit/UIKit.h>
#import "GlodBuleHTMatchHomeModel.h"
@interface GlodBuleHTMatchHomeCell : UITableViewCell
- (void)taosetupWithMatchModel:(GlodBuleHTMatchHomeModel *)matchModel;

@property (weak, nonatomic) IBOutlet UIView *backPlayView;

@end
