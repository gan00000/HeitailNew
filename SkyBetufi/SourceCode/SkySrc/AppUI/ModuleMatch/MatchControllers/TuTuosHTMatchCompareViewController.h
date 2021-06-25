#import "MMoogPPXXBJBaseViewController.h"
#import "KSasxHTMatchSummaryModel.h"
#import "FFlaliHTMatchLiveFeedModel.h"
#import "TuTuosHTMatchHomeModel.h"
#import "BByasHTMatchCompareModel.h"

@interface TuTuosHTMatchCompareViewController : MMoogPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
//- (void)taorefreshWithMatchSummaryModel:(KSasxHTMatchSummaryModel *)summaryModel;
- (void)taorefreshWithMatchSummaryModel:(KSasxHTMatchSummaryModel *)summaryModel matchCompareModel:(BByasHTMatchCompareModel *)matchCompareModel liveFeedModel:(NSArray<FFlaliHTMatchLiveFeedModel *> *)liveFeedModel matchModel:(TuTuosHTMatchHomeModel *)matchModel;
@end
