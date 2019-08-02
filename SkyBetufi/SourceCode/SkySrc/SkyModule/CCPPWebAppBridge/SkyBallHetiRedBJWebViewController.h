#import "SkyBallHetiRedPPXXBJBaseNavigationController.h"
#import "SkyBallHetiRedPPXXBJBaseViewController.h"
#import <WebKit/WebKit.h>
@interface SkyBallHetiRedBJWebViewController : SkyBallHetiRedPPXXBJBaseViewController <WKNavigationDelegate, WKUIDelegate, BJNavigationDelegate>
@property (nonatomic, strong, readonly) WKWebView *webView;
- (instancetype)initWithAddress:(NSString *)urlString;
- (instancetype)initWithAddress:(NSString *)urlString postParams:(NSDictionary *)pastParams;
- (instancetype)initWithHTML:(NSString *)htmlString;
- (void)setShareState:(BOOL)canShare
          shareParams:(NSDictionary *)params
    shareSuccessBlock:(dispatch_block_t)successBlock;
@end
