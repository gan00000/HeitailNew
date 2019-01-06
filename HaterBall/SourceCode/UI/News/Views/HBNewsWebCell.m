#import "HBNewsWebCell.h"
#import <WebKit/WebKit.h>
@interface HBNewsWebCell ()<WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) UIScrollView *webContentView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL hasLoad;
@property (nonatomic, assign) BOOL haveGetHeight;
@end
@implementation HBNewsWebCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.webContentView];
}
- (void)dealloc {
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    BJLog(@"cell: %@ dealloc", NSStringFromClass([self class]));
}
- (void)setupWithClearHtmlContent:(NSString *)htmlContent {
    if (!htmlContent) {
        return;
    }
    if (self.hasLoad) {
        return;
    }
    self.hasLoad = YES;
    [self.webView loadHTMLString:htmlContent baseURL:nil];
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    __weak typeof(self) weakSelf = self;
    if ([keyPath isEqualToString:@"contentSize"]) {
        if (self.haveGetHeight) {
            return;
        }
        [self.webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat height = [result doubleValue];
                weakSelf.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
                weakSelf.webContentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
                weakSelf.webContentView.contentSize =CGSizeMake(SCREEN_WIDTH, height);
                if (weakSelf.onContentHeightUpdateBlock) {
                    weakSelf.onContentHeightUpdateBlock(height);
                }
            });            
        }];
    }
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.scheme isEqualToString:@"haters"]) {
        NSString *url = navigationAction.request.URL.absoluteString;
        if ([RX(@"://height=") isMatch:url]) {
            NSArray *arr = [url componentsSeparatedByString:@"="];
            CGFloat height = [arr.lastObject floatValue];
            if (height > 0) {
                self.haveGetHeight = YES;
                if (self.onContentHeightUpdateBlock) {
                    self.onContentHeightUpdateBlock(height);
                }
            }            
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark - getters
- (UIScrollView *)webContentView {
    if (!_webContentView) {
        _webContentView = [[UIScrollView alloc] init];
        [_webContentView addSubview:self.webView];
    }
    return _webContentView;
}
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}
@end
