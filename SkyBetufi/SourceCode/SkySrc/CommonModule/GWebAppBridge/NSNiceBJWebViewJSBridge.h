#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WKWebViewJavascriptBridge.h"
@class MMoogBJWebViewController;
@class WKWebView;
@interface NSNiceBJWebViewJSBridge : NSObject
@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *jsBridge;
@property (nonatomic, assign) BOOL canGoBack;
- (instancetype)initWithWebView:(WKWebView *)webView viewController:(MMoogBJWebViewController *)viewController;
- (void)registerBridges;
@end
