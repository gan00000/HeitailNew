#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WKWebViewJavascriptBridge.h"
@class SkyBallHetiRedBJWebViewController;
@class WKWebView;
@interface SkyBallHetiRedBJWebViewJSBridge : NSObject
@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *jsBridge;
@property (nonatomic, assign) BOOL canGoBack;
- (instancetype)initWithWebView:(WKWebView *)webView viewController:(SkyBallHetiRedBJWebViewController *)viewController;
- (void)registerBridges;
@end
