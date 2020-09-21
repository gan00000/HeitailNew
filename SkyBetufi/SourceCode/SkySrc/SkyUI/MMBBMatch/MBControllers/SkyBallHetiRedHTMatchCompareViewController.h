#import "SkyBallHetiRedPPXXBJBaseViewController.h"
#import "SkyBallHetiRedHTMatchSummaryModel.h"
#import "SkyBallHetiRedHTMatchLiveFeedModel.h"

@interface SkyBallHetiRedHTMatchCompareViewController : SkyBallHetiRedPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
//- (void)waterSkyrefreshWithMatchSummaryModel:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel;
- (void)waterSkyrefreshWithMatchSummaryModel:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *)liveFeedModel;
@end
