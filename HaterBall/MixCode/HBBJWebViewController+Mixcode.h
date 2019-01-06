#import "HBBJBaseNavigationController.h"
#import "HBBJBaseViewController.h"
#import <WebKit/WebKit.h>
#import "HBBJWebViewController.h"
#import "HBBJWebViewJSBridge.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "YYModel.h"
#import "HBBJURINavigator.h"
#import "HBBJUtility.h"
#import "BJAPIAddress.h"
#import "HBBJWebViewCacheHelper.h"
#import "UIView+EmptyView.h"

@interface HBBJWebViewController (Mixcode)
- (void)initWithAddress:(NSString *)urlString mixcode:(NSString *)mixcode;
- (void)initWithAddress:(NSString *)urlString postParams:(NSDictionary *)postParams mixcode:(NSString *)mixcode;
- (void)initWithHTML:(NSString *)htmlString mixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)viewDidDisappear:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)deallocMixcode:(NSString *)mixcode;
- (void)setupViewsMixcode:(NSString *)mixcode;
- (void)setupWebViewKVOMixcode:(NSString *)mixcode;
- (void)setupJSBridgeMixcode:(NSString *)mixcode;
- (void)setShareState:(BOOL)canShare shareParams:(NSDictionary *)params shareSuccessBlock:(dispatch_block_t)successBlock mixcode:(NSString *)mixcode;
- (void)onUserProfileUpdateMixcode:(NSString *)mixcode;
- (void)bj_shouldHandlePopActionMySelfMixcode:(NSString *)mixcode;
- (void)bj_handlePopActionMySelfMixcode:(NSString *)mixcode;
- (void)bj_shouldForbidSlideBackActionMixcode:(NSString *)mixcode;
- (void)shareButtonActionMixcode:(NSString *)mixcode;
- (void)closeButtonActionMixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler mixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation mixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation mixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation mixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error mixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error mixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler mixcode:(NSString *)mixcode;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context mixcode:(NSString *)mixcode;
- (void)webViewMixcode:(NSString *)mixcode;
- (void)progressViewMixcode:(NSString *)mixcode;
- (void)p_postRequestWithJSMixcode:(NSString *)mixcode;
- (void)p_loadLocalHTMLString:(NSString *)htmlString mixcode:(NSString *)mixcode;

@end
