#import <UIKit/UIKit.h>
#import "SundayHTMatchHomeModel.h"
@interface YYPackageHTMatchHomeCell : UITableViewCell
- (void)taosetupWithMatchModel:(SundayHTMatchHomeModel *)matchModel matchType:(NSString *)matchType;

@property (weak, nonatomic) IBOutlet UIView *backPlayView;

@end
