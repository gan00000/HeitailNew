#import <UIKit/UIKit.h>
#import "HBNewsWebCell.h"
#import <WebKit/WebKit.h>

@interface HBNewsWebCell (Mixcode)
- (void)awakeFromNibMixcode:(NSString *)mixcode;
- (void)deallocMixcode:(NSString *)mixcode;
- (void)setupWithClearHtmlContent:(NSString *)htmlContent mixcode:(NSString *)mixcode;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context mixcode:(NSString *)mixcode;
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler mixcode:(NSString *)mixcode;
- (void)webContentViewMixcode:(NSString *)mixcode;
- (void)webViewMixcode:(NSString *)mixcode;

@end
