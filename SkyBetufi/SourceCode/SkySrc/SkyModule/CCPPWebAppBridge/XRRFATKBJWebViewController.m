//
//  XRRFATKBJWebViewController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/25.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKBJWebViewController.h"
#import "XRRFATKBJWebViewJSBridge.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "YYModel.h"
#import "XRRFATKBJURINavigator.h"
#import "XRRFATKBJUtility.h"
#import "BJAPIAddress.h"
#import "XRRFATKBJWebViewCacheHelper.h"
#import "UIView+XRRFATKEmptyView.h"

typedef NS_ENUM(NSInteger, BJWebViewInitType) {
    BJWebViewInitTypeNormal,
    BJWebViewInitTypePost,
    BJWebViewInitTypeLocalHTML
};

static void *kWebViewKVOContext;

@interface XRRFATKBJWebViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
//@property (nonatomic, strong) UIBarButtonItem *closeBarButton;
@property (nonatomic, copy) NSDictionary *shareParams;
//为了在JS Bridge能回调分享的结果，需要持有这个block
@property (nonatomic, copy) dispatch_block_t shareSuccessJSCallback;

@property (nonatomic, assign) BJWebViewInitType webViewInitType;

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) XRRFATKBJWebViewJSBridge *jsBridge;

@property (nonatomic, copy) NSDictionary *postParams;
@property (nonatomic, assign) BOOL needLoadJSPOST;

@property (nonatomic, copy) NSString *localHtmlString;

//@property (nonatomic, strong) WKWebView *tempUAWebView; //用于第一次修改UA时使用，修改后马上释放

@property (nonatomic, assign) BOOL needUpdateUserProfile; //打开了汇付页面，页面关闭后需要更新用户信息


@end

@implementation XRRFATKBJWebViewController


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

    //[self p_setupCustomUAIfNeeded];
    
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
                //[self.webView loadHTMLString:self.localHtmlString baseURL:nil];
                [self p_loadLocalHTMLString:self.localHtmlString];
            }
                break;
            default:
                break;
        }
    });
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserProfileUpdate) name:kUserProfileUpdateNotification object:nil];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.needUpdateUserProfile) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kUserProfileNeedUpdateNotificaiton object:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserProfileUpdateNotification object:nil];
    
    BJLog(@"webview dealloc");
}

- (void)setupViews {
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
#if BJ_DEBUG //给测试看，标记此页面为H5
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
    self.jsBridge = [[XRRFATKBJWebViewJSBridge alloc] initWithWebView:self.webView viewController:self];
    [self.jsBridge registerBridges];
}

#pragma mark -
- (void)setShareState:(BOOL)canShare shareParams:(NSDictionary *)params shareSuccessBlock:(dispatch_block_t)successBlock {
    self.shareParams = params;
    self.shareSuccessJSCallback = successBlock;
    
    if (canShare) {
        /*
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_share"]
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(shareButtonAction)];
         */
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(shareButtonAction)];
    } else {
        self.navigationItem.rightBarButtonItems = nil;
#if BJ_DEBUG //给测试看，标记此页面为H5
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"[H5]"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:nil
                                                                                 action:nil];
#endif
    }
}

#pragma mark - Notification
- (void)onUserProfileUpdate {
    //刷新页面
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
//    NSString *url = self.shareParams[@"link"];
//    NSString *title = self.shareParams[@"title"];
//    NSString *desc = self.shareParams[@"desc"];
//    NSString *imgUrl = self.shareParams[@"imgUrl"];
//    [[BJShareManager shareManager] shareWebWithUrl:[NSURL URLWithString:url]
//                                             title:title
//                                              text:desc
//                                        thumbImage:imgUrl
//                                            inView:self.view
//                                      successBlock:^{
//
//                                          if (self.shareSuccessJSCallback) {
//                                              self.shareSuccessJSCallback();
//                                          }
//
//                                      }];
}

- (void)closeButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *url = navigationAction.request.URL.absoluteString;
    if ([navigationAction.request.URL.scheme isEqualToString:BJURIScheme]) {
        BOOL result = [[XRRFATKBJURINavigator sharedInstance] handleURI:url];
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
    
//    if ([url containsString:H5_HUIFU_DOMAIN]) { //打开的是汇付页面，结束后需要更新用户信息
//        self.needUpdateUserProfile = YES;
//    }
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
    //__weak typeof(self)weakSelf = self;
    //[self.view showEmptyViewWithTitle:@"加载失败"];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //__weak typeof(self)weakSelf = self;
    //[self.view showEmptyViewWithTitle:@"加载失败"];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
//    BJAlertView *alertView = [[BJAlertView alloc] initWithTitle:nil message:message];
//    [alertView addHighlightButtonWithTitle:@"好" block:nil];
//    [alertView show];
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
// 调用JS发送POST请求
- (void)p_postRequestWithJS {
    NSString *postParams = [self.postParams yy_modelToJSONString];
    // 拼装成调用JavaScript的字符串
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

/*
- (void)p_setupCustomUAIfNeeded {
    
    //NSLog(@"---------p_setupCustomUAIfNeeded begin >%f", [[NSDate date] timeIntervalSince1970]);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        self.tempUAWebView = [[WKWebView alloc] init];
        
        __block BOOL waiting = YES;
        [self.tempUAWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
            NSString *uaStr = result;
            if ([uaStr containsString:@"zhugeapp/"]) {
                //NSLog(@"");
            } else {
                NSString *zhugeUA = [NSString stringWithFormat:@" zhugeapp/%@", [XRRFATKBJUtility appVersion]];
                NSString *newUserAgent = [result stringByAppendingString:zhugeUA];
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : newUserAgent}];
            }
            waiting = NO;
        }];
        while (waiting) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        self.tempUAWebView = nil;
        
        //清除所有缓存
        [XRRFATKBJWebViewCacheHelper removeAllCache];
        
    });
    
    //NSLog(@"---------p_setupCustomUAIfNeeded end >%f", [[NSDate date] timeIntervalSince1970]);
}
 */

@end
