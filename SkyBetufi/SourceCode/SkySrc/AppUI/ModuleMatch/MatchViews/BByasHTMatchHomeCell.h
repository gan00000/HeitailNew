#import <UIKit/UIKit.h>
#import "FFlaliHTMatchHomeModel.h"
@interface BByasHTMatchHomeCell : UITableViewCell
- (void)taosetupWithMatchModel:(FFlaliHTMatchHomeModel *)matchModel matchType:(NSString *)matchType;

@property (weak, nonatomic) IBOutlet UIView *backPlayView;

@end
