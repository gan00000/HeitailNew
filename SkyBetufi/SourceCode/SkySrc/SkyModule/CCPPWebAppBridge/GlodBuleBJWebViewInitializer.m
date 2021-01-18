#import "GlodBuleBJWebViewInitializer.h"
#import <WebKit/WebKit.h>
#import "GlodBuleBJUtility.h"
#import "GlodBuleBJWebViewCacheHelper.h"
@interface GlodBuleBJWebViewInitializer()
@property (nonatomic, strong) WKWebView *tempUAWebView; 
@end
@implementation GlodBuleBJWebViewInitializer
+ (instancetype)sharedInstance {
    static GlodBuleBJWebViewInitializer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlodBuleBJWebViewInitializer alloc] init];
    });
    return instance;
}
- (void)setupWebViewWithCompletion:(void (^)(void))completion {
    self.tempUAWebView = [[WKWebView alloc] init];
    [self.tempUAWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *uaStr = result;
        if ([uaStr containsString:@"zhugeapp/"]) {
        } else {
            NSString *zhugeUA = [NSString stringWithFormat:@" zhugeapp/%@", [GlodBuleBJUtility appVersion]];
            NSString *newUserAgent = [uaStr stringByAppendingString:zhugeUA];
            if (newUserAgent) {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : newUserAgent}];                
            } else {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : zhugeUA}];
            }
        }
        [GlodBuleBJWebViewCacheHelper removeAllCache];
        if (completion) {
            completion();
        }
    }];
}
@end
