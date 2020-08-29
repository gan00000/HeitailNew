#import "SkyBallHetiRedPPXXBJBaseViewController.h"
#import "SkyBallHetiRedHTMatchLiveFeedModel.h"
#import "SkyBallHetiRedHTMatchSummaryModel.h"
@interface SkyBallHetiRedHTMatchWordLiveViewController : SkyBallHetiRedPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)waterSkyrefreshWithLiveFeedList:(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *)liveFeedList summary:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel;
@end
