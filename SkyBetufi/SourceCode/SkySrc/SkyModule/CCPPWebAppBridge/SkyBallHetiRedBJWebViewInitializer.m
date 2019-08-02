#import "SkyBallHetiRedBJWebViewInitializer.h"
#import <WebKit/WebKit.h>
#import "SkyBallHetiRedBJUtility.h"
#import "SkyBallHetiRedBJWebViewCacheHelper.h"
@interface SkyBallHetiRedBJWebViewInitializer()
@property (nonatomic, strong) WKWebView *tempUAWebView; 
@end
@implementation SkyBallHetiRedBJWebViewInitializer
+ (instancetype)sharedInstance {
    static SkyBallHetiRedBJWebViewInitializer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SkyBallHetiRedBJWebViewInitializer alloc] init];
    });
    return instance;
}
- (void)setupWebViewWithCompletion:(void (^)(void))completion {
    self.tempUAWebView = [[WKWebView alloc] init];
    [self.tempUAWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *uaStr = result;
        if ([uaStr containsString:@"zhugeapp/"]) {
        } else {
            NSString *zhugeUA = [NSString stringWithFormat:@" zhugeapp/%@", [SkyBallHetiRedBJUtility appVersion]];
            NSString *newUserAgent = [uaStr stringByAppendingString:zhugeUA];
            if (newUserAgent) {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : newUserAgent}];                
            } else {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : zhugeUA}];
            }
        }
        [SkyBallHetiRedBJWebViewCacheHelper removeAllCache];
        if (completion) {
            completion();
        }
    }];
}
@end
