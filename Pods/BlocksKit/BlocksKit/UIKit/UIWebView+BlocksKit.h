#import <UIKit/UIKit.h>
@interface UIWebView (BlocksKit)
@property (nonatomic, copy, setter = bk_setShouldStartLoadBlock:) BOOL (^bk_shouldStartLoadBlock)(UIWebView *webView, NSURLRequest *request, UIWebViewNavigationType navigationType);
@property (nonatomic, copy, setter = bk_setDidStartLoadBlock:) void (^bk_didStartLoadBlock)(UIWebView *webView);
@property (nonatomic, copy, setter = bk_setDidFinishLoadBlock:) void (^bk_didFinishLoadBlock)(UIWebView *webView);
@property (nonatomic, copy, setter = bk_setDidFinishWithErrorBlock:) void (^bk_didFinishWithErrorBlock)(UIWebView *webView, NSError *error);
@end
