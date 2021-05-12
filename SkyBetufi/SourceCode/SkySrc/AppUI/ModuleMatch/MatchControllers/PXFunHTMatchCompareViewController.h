#import "CCCasePPXXBJBaseViewController.h"
#import "NDeskHTMatchSummaryModel.h"
#import "SundayHTMatchLiveFeedModel.h"
#import "SundayHTMatchHomeModel.h"
#import "PXFunHTMatchCompareModel.h"

@interface PXFunHTMatchCompareViewController : CCCasePPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
//- (void)taorefreshWithMatchSummaryModel:(NDeskHTMatchSummaryModel *)summaryModel;
- (void)taorefreshWithMatchSummaryModel:(NDeskHTMatchSummaryModel *)summaryModel matchCompareModel:(PXFunHTMatchCompareModel *)matchCompareModel liveFeedModel:(NSArray<SundayHTMatchLiveFeedModel *> *)liveFeedModel matchModel:(SundayHTMatchHomeModel *)matchModel;
@end
