#import <UIKit/UIKit.h>
#import "UUaksHTMatchLiveFeedModel.h"
#import "NSNiceHTMatchSummaryModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface WSKggHTMatchLiveFeedCell : UITableViewCell
- (void)taosetupWithMatchLiveFeedModel:(UUaksHTMatchLiveFeedModel *)feedModel summary:(NSNiceHTMatchSummaryModel *)summaryModel;
@end
NS_ASSUME_NONNULL_END
