//
//  XRRFATKBJWebViewController.h
//  BenjiaPro
//
//  Created by Marco on 2017/5/25.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKPPXXBJBaseNavigationController.h"
#import "XRRFATKPPXXBJBaseViewController.h"
#import <WebKit/WebKit.h>

@interface XRRFATKBJWebViewController : XRRFATKPPXXBJBaseViewController <WKNavigationDelegate, WKUIDelegate, BJNavigationDelegate>

@property (nonatomic, strong, readonly) WKWebView *webView;

- (instancetype)initWithAddress:(NSString *)urlString;
- (instancetype)initWithAddress:(NSString *)urlString postParams:(NSDictionary *)pastParams;
- (instancetype)initWithHTML:(NSString *)htmlString;

//JS调用显示分享按钮，分享成功需要回调结果，分享参数和回调的block都需要作为属性保留
- (void)setShareState:(BOOL)canShare
          shareParams:(NSDictionary *)params
    shareSuccessBlock:(dispatch_block_t)successBlock;


@end
