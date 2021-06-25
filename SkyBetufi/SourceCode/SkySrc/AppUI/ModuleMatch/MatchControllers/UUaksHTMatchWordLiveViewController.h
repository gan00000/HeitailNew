#import "WSKggPPXXBJBaseViewController.h"
#import "UUaksHTMatchLiveFeedModel.h"
#import "NSNiceHTMatchSummaryModel.h"
@interface UUaksHTMatchWordLiveViewController : WSKggPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)taorefreshWithLiveFeedList:(NSArray<UUaksHTMatchLiveFeedModel *> *)liveFeedList summary:(NSNiceHTMatchSummaryModel *)summaryModel gameId:(NSString *)gameId;
@end
