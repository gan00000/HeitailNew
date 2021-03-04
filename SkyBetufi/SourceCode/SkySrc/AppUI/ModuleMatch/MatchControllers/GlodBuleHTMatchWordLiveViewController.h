#import "GlodBulePPXXBJBaseViewController.h"
#import "GlodBuleHTMatchLiveFeedModel.h"
#import "GlodBuleHTMatchSummaryModel.h"
@interface GlodBuleHTMatchWordLiveViewController : GlodBulePPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)taorefreshWithLiveFeedList:(NSArray<GlodBuleHTMatchLiveFeedModel *> *)liveFeedList summary:(GlodBuleHTMatchSummaryModel *)summaryModel gameId:(NSString *)gameId;
@end
