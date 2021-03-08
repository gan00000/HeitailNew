#import "GlodBulePPXXBJBaseViewController.h"
#import "GlodBuleHTMatchSummaryModel.h"
#import "GlodBuleHTMatchLiveFeedModel.h"
#import "GlodBuleHTMatchHomeModel.h"

@interface GlodBuleHTMatchCompareViewController : GlodBulePPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
//- (void)taorefreshWithMatchSummaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel;
- (void)taorefreshWithMatchSummaryModel:(GlodBuleHTMatchSummaryModel *)summaryModel liveFeedModel:(NSArray<GlodBuleHTMatchLiveFeedModel *> *)liveFeedModel matchModel:(GlodBuleHTMatchHomeModel *)matchModel;
@end
