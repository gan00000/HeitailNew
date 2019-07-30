#import "XRRFATKBJWebViewInitializer.h"
#import <WebKit/WebKit.h>
#import "XRRFATKBJUtility.h"
#import "XRRFATKBJWebViewCacheHelper.h"
@interface XRRFATKBJWebViewInitializer()
@property (nonatomic, strong) WKWebView *tempUAWebView; 
@end
@implementation XRRFATKBJWebViewInitializer
+ (instancetype)sharedInstance {
    static XRRFATKBJWebViewInitializer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XRRFATKBJWebViewInitializer alloc] init];
    });
    return instance;
}
- (void)setupWebViewWithCompletion:(void (^)(void))completion {
    self.tempUAWebView = [[WKWebView alloc] init];
    [self.tempUAWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *uaStr = result;
        if ([uaStr containsString:@"zhugeapp/"]) {
        } else {
            NSString *zhugeUA = [NSString stringWithFormat:@" zhugeapp/%@", [XRRFATKBJUtility appVersion]];
            NSString *newUserAgent = [uaStr stringByAppendingString:zhugeUA];
            if (newUserAgent) {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : newUserAgent}];                
            } else {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : zhugeUA}];
            }
        }
        [XRRFATKBJWebViewCacheHelper removeAllCache];
        if (completion) {
            completion();
        }
    }];
}
@end
