#import <UIKit/UIKit.h>
#import "SundayHTMatchLiveFeedModel.h"
#import "NDeskHTMatchSummaryModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface RRDogHTMatchLiveFeedCell : UITableViewCell
- (void)taosetupWithMatchLiveFeedModel:(SundayHTMatchLiveFeedModel *)feedModel summary:(NDeskHTMatchSummaryModel *)summaryModel;
@end
NS_ASSUME_NONNULL_END
