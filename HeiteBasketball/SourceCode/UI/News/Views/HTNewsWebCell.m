//
//  HTNewsWebCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTNewsWebCell.h"
#import <WebKit/WebKit.h>

@interface HTNewsWebCell ()

@property (nonatomic, strong) UIScrollView *webContentView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HTNewsWebCell

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
    [self.webView loadHTMLString:htmlContent baseURL:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    __weak typeof(self) weakSelf = self;
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self.webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            CGFloat height = [result doubleValue];
            weakSelf.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
            weakSelf.webContentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
            weakSelf.webContentView.contentSize =CGSizeMake(SCREEN_WIDTH, height);
            
            if (weakSelf.onContentHeightUpdateBlock) {
                weakSelf.onContentHeightUpdateBlock(height);
            }
        }];
    }
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
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

@end














