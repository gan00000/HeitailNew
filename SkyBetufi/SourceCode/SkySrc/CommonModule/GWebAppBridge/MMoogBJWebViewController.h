#import "BByasPPXXBJBaseNavigationController.h"
#import "WSKggPPXXBJBaseViewController.h"
#import <WebKit/WebKit.h>
@interface MMoogBJWebViewController : WSKggPPXXBJBaseViewController <WKNavigationDelegate, WKUIDelegate, BJNavigationDelegate>
@property (nonatomic, strong, readonly) WKWebView *webView;
- (instancetype)initWithAddress:(NSString *)urlString;
- (instancetype)initWithAddress:(NSString *)urlString postParams:(NSDictionary *)pastParams;
- (instancetype)initWithHTML:(NSString *)htmlString;
- (void)setShareState:(BOOL)canShare
          shareParams:(NSDictionary *)params
    shareSuccessBlock:(dispatch_block_t)successBlock;
@end
