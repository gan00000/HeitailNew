#import "CCCasePPXXBJBaseViewController.h"
#import "SundayHTMatchLiveFeedModel.h"
#import "NDeskHTMatchSummaryModel.h"
@interface RRDogHTMatchWordLiveViewController : CCCasePPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)taorefreshWithLiveFeedList:(NSArray<SundayHTMatchLiveFeedModel *> *)liveFeedList summary:(NDeskHTMatchSummaryModel *)summaryModel gameId:(NSString *)gameId;
@end
