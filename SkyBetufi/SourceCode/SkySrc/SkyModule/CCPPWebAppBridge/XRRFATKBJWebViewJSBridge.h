#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WKWebViewJavascriptBridge.h"
@class XRRFATKBJWebViewController;
@class WKWebView;
@interface XRRFATKBJWebViewJSBridge : NSObject
@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *jsBridge;
@property (nonatomic, assign) BOOL canGoBack;
- (instancetype)initWithWebView:(WKWebView *)webView viewController:(XRRFATKBJWebViewController *)viewController;
- (void)registerBridges;
@end
