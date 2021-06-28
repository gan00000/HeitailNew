#import "MMoogPPXXBJBaseViewController.h"
#import "FFlaliHTMatchLiveFeedModel.h"
#import "KSasxHTMatchSummaryModel.h"
@interface KSasxHTMatchWordLiveViewController : MMoogPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)taorefreshWithLiveFeedList:(NSArray<FFlaliHTMatchLiveFeedModel *> *)liveFeedList summary:(KSasxHTMatchSummaryModel *)summaryModel gameId:(NSString *)gameId;
@end
