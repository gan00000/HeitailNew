#import "WSKggPPXXBJBaseViewController.h"
#import "NSNiceHTMatchSummaryModel.h"
#import "UUaksHTMatchLiveFeedModel.h"
#import "FFlaliHTMatchHomeModel.h"
#import "WSKggHTMatchCompareModel.h"

@interface WSKggHTMatchCompareViewController : WSKggPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
//- (void)taorefreshWithMatchSummaryModel:(NSNiceHTMatchSummaryModel *)summaryModel;
- (void)taorefreshWithMatchSummaryModel:(NSNiceHTMatchSummaryModel *)summaryModel matchCompareModel:(WSKggHTMatchCompareModel *)matchCompareModel liveFeedModel:(NSArray<UUaksHTMatchLiveFeedModel *> *)liveFeedModel matchModel:(FFlaliHTMatchHomeModel *)matchModel;
@end
