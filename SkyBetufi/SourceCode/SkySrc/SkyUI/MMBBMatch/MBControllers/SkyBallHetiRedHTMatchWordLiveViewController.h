#import "SkyBallHetiRedPPXXBJBaseViewController.h"
#import "SkyBallHetiRedHTMatchLiveFeedModel.h"
@interface SkyBallHetiRedHTMatchWordLiveViewController : SkyBallHetiRedPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)waterSkyrefreshWithLiveFeedList:(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *)liveFeedList;
@end
