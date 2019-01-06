#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WKWebViewJavascriptBridge.h"
@class HBBJWebViewController;
@class WKWebView;
@interface HBBJWebViewJSBridge : NSObject
@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *jsBridge;
@property (nonatomic, assign) BOOL canGoBack;
- (instancetype)initWithWebView:(WKWebView *)webView viewController:(HBBJWebViewController *)viewController;
- (void)registerBridges;
@end
