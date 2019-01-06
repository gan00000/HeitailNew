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
typedef NS_ENUM(NSInteger, BJWebViewInitType) {
    BJWebViewInitTypeNormal,
    BJWebViewInitTypePost,
    BJWebViewInitTypeLocalHTML
};
static void *kWebViewKVOContext;
@interface HBBJWebViewController ()
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, copy) NSDictionary *shareParams;
@property (nonatomic, copy) dispatch_block_t shareSuccessJSCallback;
@property (nonatomic, assign) BJWebViewInitType webViewInitType;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) HBBJWebViewJSBridge *jsBridge;
@property (nonatomic, copy) NSDictionary *postParams;
@property (nonatomic, assign) BOOL needLoadJSPOST;
@property (nonatomic, copy) NSString *localHtmlString;
@property (nonatomic, assign) BOOL needUpdateUserProfile; 
@end
@implementation HBBJWebViewController
- (instancetype)initWithAddress:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.webViewInitType = BJWebViewInitTypeNormal;
        if (urlString) {
            self.url = [NSURL URLWithString:urlString];
        }
    }
    return self;
}
- (instancetype)initWithAddress:(NSString *)urlString postParams:(NSDictionary *)postParams {
    self = [super init];
    if (self) {
        self.webViewInitType = BJWebViewInitTypePost;
        if (urlString) {
            self.url = [NSURL URLWithString:urlString];
        }
        self.postParams = postParams;
    }
    return self;
}
- (instancetype)initWithHTML:(NSString *)htmlString {
    self = [super init];
    if (self) {
        self.webViewInitType = BJWebViewInitTypeLocalHTML;
        self.localHtmlString = htmlString;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebViewKVO];
    [self setupViews];
    [self setupJSBridge];
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (self.webViewInitType) {
            case BJWebViewInitTypeNormal:
                [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
                break;
            case BJWebViewInitTypePost: {
                NSString *postJSPath = [[NSBundle mainBundle] pathForResource:@"BJWKWebViewPostJS" ofType:@"html"];
                NSString *html = [[NSString alloc] initWithContentsOfFile:postJSPath encoding:NSUTF8StringEncoding error:nil];
                self.needLoadJSPOST = YES;
                [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
            }
                break;
            case BJWebViewInitTypeLocalHTML: {
                [self p_loadLocalHTMLString:self.localHtmlString];
            }
                break;
            default:
                break;
        }
    });
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.needUpdateUserProfile) {
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    BJLog(@"webview dealloc");
}
- (void)setupViews {
    self.navigationItem.leftItemsSupplementBackButton = YES;
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
#if BJ_DEBUG 
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"[H5]"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil];
#endif
}
- (void)setupWebViewKVO {
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:&kWebViewKVOContext];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:&kWebViewKVOContext];
}
- (void)setupJSBridge {
    self.jsBridge = [[HBBJWebViewJSBridge alloc] initWithWebView:self.webView viewController:self];
    [self.jsBridge registerBridges];
}
#pragma mark -
- (void)setShareState:(BOOL)canShare shareParams:(NSDictionary *)params shareSuccessBlock:(dispatch_block_t)successBlock {
    self.shareParams = params;
    self.shareSuccessJSCallback = successBlock;
    if (canShare) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(shareButtonAction)];
    } else {
        self.navigationItem.rightBarButtonItems = nil;
#if BJ_DEBUG 
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"[H5]"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:nil
                                                                                 action:nil];
#endif
    }
}
#pragma mark - Notification
- (void)onUserProfileUpdate {
    [self.webView reloadFromOrigin];
}
#pragma mark - BJNavigationDelegate
- (BOOL)bj_shouldHandlePopActionMySelf {
    return YES;
}
- (void)bj_handlePopActionMySelf {
    if (self.webView.canGoBack && self.jsBridge.canGoBack) {
        [self.webView goBack];
    } else {
        self.jsBridge.canGoBack = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (BOOL)bj_shouldForbidSlideBackAction {
    return self.webView.canGoBack && self.jsBridge.canGoBack;
}
#pragma mark - Actions
- (void)shareButtonAction {
}
- (void)closeButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *url = navigationAction.request.URL.absoluteString;
    if ([navigationAction.request.URL.scheme isEqualToString:BJURIScheme]) {
        BOOL result = [[HBBJURINavigator sharedInstance] handleURI:url];
        if (result) {
            decisionHandler(WKNavigationActionPolicyCancel);
        } else {
            decisionHandler(WKNavigationActionPolicyAllow);
        }
    } else if ([navigationAction.request.URL.scheme isEqualToString:@"itms-apps"]
               || [navigationAction.request.URL.scheme isEqualToString:@"itms-appss"]
               || [navigationAction.request.URL.scheme isEqualToString:@"tel"]
               || [navigationAction.request.URL.scheme isEqualToString:@"mailto"]
               || [navigationAction.request.URL.scheme isEqualToString:@"sms"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.needLoadJSPOST) {
        [self p_postRequestWithJS];
        self.needLoadJSPOST = NO;
    }
    self.url = webView.URL;
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}
#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    completionHandler();
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }
}
#pragma mark -
- (WKWebView *)webView {
    if(!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}
- (NJKWebViewProgressView *)progressView {
    if (!_progressView) {
        CGRect barFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 2);
        _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _progressView.progressBarView.backgroundColor = [UIColor blueColor];
        [_progressView setProgress:0];
    }
    return _progressView;
}
#pragma mark -
- (void)p_postRequestWithJS {
    NSString *postParams = [self.postParams yy_modelToJSONString];
    NSString *jscript = [NSString stringWithFormat:@"post('%@', %@);", self.url.absoluteString, postParams];
    [self.webView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {
    }];
}
- (void)p_loadLocalHTMLString:(NSString *)htmlString {
    NSString *cssStyleStart = @"<style> * {margin: 0;padding: 0;}";
    NSString *bodyStley = @"body{padding: 10px;color: #101010;font-size:14px;font-family: 'Helvetica Neue'; font-weight: 300;}";
    NSString *dtStyle = @"dt{margin-bottom: 0;}";
    NSString *ddStyle = @"dd {margin-bottom: 15px; line-height: 1.5; text-align: justify; display: inline-block;}";
    NSString *pStyle = @"p{text-indent: 2em;}";
    NSString *imgStyle = @"img{display: block;width: 100%;}";
    NSString *cssStyleEnd = @"</style>";
    NSString *cssStyle = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", cssStyleStart, bodyStley, dtStyle, ddStyle, pStyle, imgStyle, cssStyleEnd];
    NSString *meta = @"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\">";
    NSString *htmlStr = [NSString stringWithFormat:@"<!DOCTYPE html><html><head>%@%@</head><body>%@</body></html>", cssStyle, meta, htmlString];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}
@end
