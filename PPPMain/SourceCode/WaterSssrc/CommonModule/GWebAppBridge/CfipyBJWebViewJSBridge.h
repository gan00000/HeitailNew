#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WKWebViewJavascriptBridge.h"
@class FFlaliBJWebViewController;
@class WKWebView;
@interface CfipyBJWebViewJSBridge : NSObject
@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *jsBridge;
@property (nonatomic, assign) BOOL canGoBack;
- (instancetype)initWithWebView:(WKWebView *)webView viewController:(FFlaliBJWebViewController *)viewController;
- (void)registerBridges;
@end
