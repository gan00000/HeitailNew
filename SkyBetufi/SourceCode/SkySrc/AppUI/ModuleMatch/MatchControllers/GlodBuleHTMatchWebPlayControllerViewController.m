//
//  GlodBuleHTMatchWebPlayControllerViewController.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/10/25.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "GlodBuleHTMatchWebPlayControllerViewController.h"
#import <Masonry.h>
#import <WebKit/WebKit.h>

@interface GlodBuleHTMatchWebPlayControllerViewController ()<WKNavigationDelegate>


@property (nonatomic, strong) WKWebView *webView;

@end

@implementation GlodBuleHTMatchWebPlayControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.view);
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
    }];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.bballman.com/category/live"]]];
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f4f4"];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
        _webView.clearsContextBeforeDrawing = YES;
        _webView.clipsToBounds = YES;
    }
    return _webView;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
   
}

@end
