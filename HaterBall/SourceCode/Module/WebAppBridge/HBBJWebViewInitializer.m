#import "HBBJWebViewInitializer.h"
#import <WebKit/WebKit.h>
#import "HBBJUtility.h"
#import "HBBJWebViewCacheHelper.h"
@interface HBBJWebViewInitializer()
@property (nonatomic, strong) WKWebView *tempUAWebView; 
@end
@implementation HBBJWebViewInitializer
+ (instancetype)sharedInstance {
    static HBBJWebViewInitializer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HBBJWebViewInitializer alloc] init];
    });
    return instance;
}
- (void)setupWebViewWithCompletion:(void (^)(void))completion {
    self.tempUAWebView = [[WKWebView alloc] init];
    [self.tempUAWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *uaStr = result;
        if ([uaStr containsString:@"zhugeapp/"]) {
        } else {
            NSString *zhugeUA = [NSString stringWithFormat:@" zhugeapp/%@", [HBBJUtility appVersion]];
            NSString *newUserAgent = [uaStr stringByAppendingString:zhugeUA];
            if (newUserAgent) {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : newUserAgent}];                
            } else {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : zhugeUA}];
            }
        }
        [HBBJWebViewCacheHelper removeAllCache];
        if (completion) {
            completion();
        }
    }];
}
@end
