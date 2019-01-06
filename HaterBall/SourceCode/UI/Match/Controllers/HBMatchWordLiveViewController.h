#import "HBBJBaseViewController.h"
#import "HBMatchLiveFeedModel.h"
@interface HBMatchWordLiveViewController : HBBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)refreshWithLiveFeedList:(NSArray<HBMatchLiveFeedModel *> *)liveFeedList;
@end
