#import "SkyBallHetiRedPPXXBJBaseViewController.h"
#import "SkyBallHetiRedHTMatchSummaryModel.h"
@interface SkyBallHetiRedHTMatchCompareViewController : SkyBallHetiRedPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)waterSkyrefreshWithMatchSummaryModel:(SkyBallHetiRedHTMatchSummaryModel *)summaryModel;
@end
