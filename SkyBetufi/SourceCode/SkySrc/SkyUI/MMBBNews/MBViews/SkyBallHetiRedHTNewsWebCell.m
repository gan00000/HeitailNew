#import "SkyBallHetiRedHTNewsWebCell.h"
#import <WebKit/WebKit.h>
#import "HTImageBrowserViewController.h"
@interface SkyBallHetiRedHTNewsWebCell ()<WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) UIScrollView *webContentView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL hasLoad;
@property (nonatomic, assign) BOOL haveGetHeight;

@property (nonatomic) NSMutableArray *imageUrlArr;

@end
@implementation SkyBallHetiRedHTNewsWebCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.webContentView];
}
- (void)dealloc {
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    BJLog(@"cell: %@ dealloc", NSStringFromClass([self class]));
}
- (void)waterSkysetupWithClearHtmlContent:(NSString *)htmlContent {
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

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
     BJLog(@"webView didFinishNavigation");
    [self addImgClickJS];
}

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
    }else if ([navigationAction.request.URL.scheme isEqualToString:@"image-preview-index"]){
        //图片点击回调
       NSURL * url = navigationAction.request.URL;
       NSInteger index = [[url.absoluteString substringFromIndex:[@"image-preview-index:" length]] integerValue];
        if (self.imageUrlArr) {
            NSString * imgPath = self.imageUrlArr.count > index ? self.imageUrlArr[index]:nil;
            NSLog(@"imgPath = %@",imgPath);
            NSMutableArray *mmArr = [[NSMutableArray alloc] initWithCapacity:0];
            [mmArr addObject:@{@"url":imgPath,@"title":[NSString stringWithFormat:@"图片"]}];
//            for (int i = 0; i < self.imageUrlArr.count; i++) {
//                NSString *imageUrl = self.imageUrlArr[i];
//                [mmArr addObject:@{@"url":imageUrl,@"title":[NSString stringWithFormat:@"图片%d",i]}];
//            }

            dispatch_async(dispatch_get_main_queue(), ^{
                HTImageBrowserViewController *imageBrController = [[HTImageBrowserViewController alloc] initWithImages:mmArr];
                [[self navigationController] pushViewController:imageBrController animated:NO];
            });
        }
      
       decisionHandler(WKNavigationActionPolicyCancel);
    }else{
       decisionHandler(WKNavigationActionPolicyAllow);
    }
 
    
    
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    //预览图片
//    NSURL * url = navigationAction.request.URL;
//    if ([url.scheme isEqualToString:@"image-preview-index"]) {
//        //图片点击回调
//        NSInteger index = [[url.absoluteString substringFromIndex:[@"image-preview-index:" length]] integerValue];
//        NSString * imgPath = self.imageUrlArr.count > index?self.imageUrlArr[index]:nil;
//        NSLog(@"imgPath = %@",imgPath);
//        decisionHandler(WKNavigationActionPolicyCancel);
//    } else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    
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


- (void)addImgClickJS {
    
    //获取所以的图片标签
    [self.webView evaluateJavaScript:@"function getImages(){\
         var imgs = document.getElementsByTagName('img');\
         var imgScr = '';\
         for(var i=0;i<imgs.length;i++){\
             if (i == 0){ \
                imgScr = imgs[i].src; \
             } else {\
                imgScr = imgScr +'***'+ imgs[i].src;\
             } \
         };\
         return imgScr;\
     };" completionHandler:nil];//注入js方法

    [self.webView evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        if (!error) {
            
            NSMutableArray * urlArray = result ? [NSMutableArray arrayWithArray:[result componentsSeparatedByString:@"***"]]  : nil;
            NSLog(@"urlArray = %@",urlArray);
            self.imageUrlArr = urlArray;
        } else {
            self.imageUrlArr = nil;
        }
    }];
   
    //添加图片点击的回调
    [self.webView evaluateJavaScript:@"function registerImageClickAction(){\
         var imgs = document.getElementsByTagName('img');\
         for(var i=0;i<imgs.length;i++){\
             imgs[i].customIndex = i;\
             imgs[i].onclick=function(){\
                window.location.href='image-preview-index:'+this.customIndex;\
             }\
         }\
     }" completionHandler:nil];
    [self.webView evaluateJavaScript:@"registerImageClickAction();" completionHandler:nil];
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

//获取导航控制器
- (UINavigationController*)navigationController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}

@end
