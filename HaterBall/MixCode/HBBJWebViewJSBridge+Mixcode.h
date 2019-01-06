#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WKWebViewJavascriptBridge.h"
#import "HBBJWebViewJSBridge.h"
#import "HBBJWebViewController.h"
#import "HBBJUtility.h"
#import "YYModel.h"
#import "HBBJURINavigator.h"
#import "HBBJViewControllerCenter.h"
#import "HBMJRefreshGenerator.h"
#import <WebKit/WebKit.h>

@interface HBBJWebViewJSBridge (Mixcode)
- (void)initWithWebView:(WKWebView *)webView viewController:(HBBJWebViewController *)viewController mixcode:(NSString *)mixcode;
- (void)registerBridgesMixcode:(NSString *)mixcode;

@end
