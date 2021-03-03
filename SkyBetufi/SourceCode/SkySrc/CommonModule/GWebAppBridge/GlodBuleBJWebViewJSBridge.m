#import "GlodBuleBJWebViewJSBridge.h"
#import "GlodBuleBJWebViewController.h"
#import "GlodBuleBJUtility.h"
#import "YYModel.h"
#import "GlodBuleBJURINavigator.h"
#import "GlodBulePPXXBJViewControllerCenter.h"
#import "GlodBuleMJRefreshGenerator.h"
#import <WebKit/WebKit.h>
@interface GlodBuleBJWebViewJSBridge ()
@property (nonatomic, strong) WKWebViewJavascriptBridge *jsBridge;
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) GlodBuleBJWebViewController *webViewController;
@end
@implementation GlodBuleBJWebViewJSBridge
- (instancetype)initWithWebView:(WKWebView *)webView viewController:(GlodBuleBJWebViewController *)viewController {
    self = [super init];
    if (self) {
        self.webView = webView;
        self.webViewController = viewController;
        self.jsBridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
        [self.jsBridge setWebViewDelegate:viewController];
        self.canGoBack = YES;
    }
    return self;
}
- (void)registerBridges {
    [self.jsBridge registerHandler:@"getDeviceName" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *deviceName = [GlodBuleBJUtility modelName];
        responseCallback([@{@"device" : deviceName} yy_modelToJSONString]);
    }];
    [self.jsBridge registerHandler:@"getOSType" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback([@{@"os_type" : @"1"} yy_modelToJSONString]);
    }];
    [self.jsBridge registerHandler:@"getOSVersion" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *systemVersion = [GlodBuleBJUtility systemVersion];
        responseCallback([@{@"os_version" : systemVersion} yy_modelToJSONString]);
    }];
    [self.jsBridge registerHandler:@"getScreenWidth" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *width = @([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale).stringValue;
        responseCallback([@{@"width" : width} yy_modelToJSONString]);
    }];
    [self.jsBridge registerHandler:@"getScreenHeight" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *height = @([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale).stringValue;
        responseCallback([@{@"height" : height} yy_modelToJSONString]);
    }];
    [self.jsBridge registerHandler:@"getNetworkState" handler:^(id data, WVJBResponseCallback responseCallback) {
        responseCallback(@"");
    }];
    [self.jsBridge registerHandler:@"getCarrierName" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *carrier = [GlodBuleBJUtility carrierName];
        responseCallback([@{@"carrier" : carrier} yy_modelToJSONString]);
    }];
    [self.jsBridge registerHandler:@"getAppVersion" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *appVersion = [GlodBuleBJUtility appVersion];
        responseCallback([@{@"version" : appVersion} yy_modelToJSONString]);
    }];
    [self.jsBridge registerHandler:@"getUdid" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *udid = [GlodBuleBJUtility idfa];
        responseCallback([@{@"udid" : udid} yy_modelToJSONString]);
    }];
    [self.jsBridge registerHandler:@"getDeviceInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *width = @([UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale).stringValue;
        NSString *height = @([UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale).stringValue;
        NSDictionary *deviceInfo = @{ @"device_name" : [GlodBuleBJUtility modelName],
                                      @"os_type" : @"1",
                                      @"os_version" : [GlodBuleBJUtility systemVersion],
                                      @"screen_width" :  width,
                                      @"screen_height" : height };
        NSString *infoString = [deviceInfo yy_modelToJSONString];
        responseCallback(infoString);
    }];
    [self.jsBridge registerHandler:@"backToMainPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSInteger tab = [data[@"tab"] integerValue];
        if (tab > 3) {
            tab = 0;
        }
        [[GlodBulePPXXBJViewControllerCenter currentViewController].navigationController popToRootViewControllerAnimated:NO];
        [GlodBulePPXXBJViewControllerCenter mainViewController].selectedIndex = tab;
    }];
    [self.jsBridge registerHandler:@"backToLastPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        BOOL animated = YES;
        if (data[@"animated"]) {
            animated = [data[@"animated"] integerValue] == 1;
        }
        [[GlodBulePPXXBJViewControllerCenter currentViewController].navigationController popViewControllerAnimated:animated];
    }];
    [self.jsBridge registerHandler:@"gotoPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *uri = data[@"url"];
        [[GlodBuleBJURINavigator sharedInstance] handleURI:uri];
    }];
    __weak typeof(self)weakSelf = self;
    [self.jsBridge registerHandler:@"canGoBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([data[@"result"] integerValue] == -1) {
            weakSelf.canGoBack = NO;
            weakSelf.webView.allowsBackForwardNavigationGestures = NO;
        }
    }];
    [self.jsBridge registerHandler:@"canPullToRefresh" handler:^(id data, WVJBResponseCallback responseCallback) {
        if ([data[@"result"] integerValue] == 1) {
            weakSelf.webView.scrollView.mj_header = [GlodBuleMJRefreshGenerator bj_headerWithRefreshingBlock:^{
                [weakSelf.webView reloadFromOrigin];
                [weakSelf.webView.scrollView.mj_header performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
            }];
        } else {
            weakSelf.webView.scrollView.mj_header = nil;
        }
    }];
    [self.jsBridge registerHandler:@"pageShareState" handler:^(id data, WVJBResponseCallback responseCallback) {
        BOOL canShare = [data[@"open"] integerValue] == 1;
        [weakSelf.webViewController setShareState:canShare shareParams:data shareSuccessBlock:^{
            responseCallback([@{@"result" : @1} yy_modelToJSONString]);
        }];
    }];
}
@end