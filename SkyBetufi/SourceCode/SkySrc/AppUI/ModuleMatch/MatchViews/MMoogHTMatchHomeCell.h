#import <UIKit/UIKit.h>
#import "TuTuosHTMatchHomeModel.h"
@interface MMoogHTMatchHomeCell : UITableViewCell
- (void)taosetupWithMatchModel:(TuTuosHTMatchHomeModel *)matchModel matchType:(NSString *)matchType;

@property (weak, nonatomic) IBOutlet UIView *backPlayView;

@end
