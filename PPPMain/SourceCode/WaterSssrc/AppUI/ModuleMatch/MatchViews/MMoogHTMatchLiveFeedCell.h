#import <UIKit/UIKit.h>
#import "FFlaliHTMatchLiveFeedModel.h"
#import "KSasxHTMatchSummaryModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface MMoogHTMatchLiveFeedCell : UITableViewCell
- (void)taosetupWithMatchLiveFeedModel:(FFlaliHTMatchLiveFeedModel *)feedModel summary:(KSasxHTMatchSummaryModel *)summaryModel;
@end
NS_ASSUME_NONNULL_END
