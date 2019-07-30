#import "XRRFATKPPXXBJBaseViewController.h"
#import "XRRFATKHTMatchLiveFeedModel.h"
@interface XRRFATKHTMatchWordLiveViewController : XRRFATKPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)skargrefreshWithLiveFeedList:(NSArray<XRRFATKHTMatchLiveFeedModel *> *)liveFeedList;
@end
