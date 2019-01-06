#import "HBBJWebViewJSBridge+Mixcode.h"
@implementation HBBJWebViewJSBridge (Mixcode)
- (void)initWithWebView:(WKWebView *)webView viewController:(HBBJWebViewController *)viewController mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)registerBridgesMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
