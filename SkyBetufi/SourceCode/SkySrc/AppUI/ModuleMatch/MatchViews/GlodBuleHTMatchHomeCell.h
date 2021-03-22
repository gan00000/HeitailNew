#import <UIKit/UIKit.h>
#import "GlodBuleHTMatchHomeModel.h"
@interface GlodBuleHTMatchHomeCell : UITableViewCell
- (void)taosetupWithMatchModel:(GlodBuleHTMatchHomeModel *)matchModel matchType:(NSString *)matchType;

@property (weak, nonatomic) IBOutlet UIView *backPlayView;

@end
