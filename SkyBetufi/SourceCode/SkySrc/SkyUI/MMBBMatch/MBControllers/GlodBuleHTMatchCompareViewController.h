#import "GlodBulePPXXBJBaseViewController.h"
#import "GlodBuleHTMatchSummaryModel.h"
#import "GlodBuleHTMatchLiveFeedModel.h"

@interface GlodBuleHTMatchCompareViewController : GlodBulePPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
//- (void)waterSkyrefreshWithMatchSummaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel;
- (void)waterSkyrefreshWithMatchSummaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<GlodBuleHTMatchLiveFeedModel *> *)liveFeedModel;
@end
