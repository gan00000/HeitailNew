#import "KSasxBJWebViewInitializer.h"
#import <WebKit/WebKit.h>
#import "UUaksBJUtility.h"
#import "WSKggBJWebViewCacheHelper.h"
@interface KSasxBJWebViewInitializer()
@property (nonatomic, strong) WKWebView *tempUAWebView; 
@end
@implementation KSasxBJWebViewInitializer
+ (instancetype)sharedInstance {
    static KSasxBJWebViewInitializer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KSasxBJWebViewInitializer alloc] init];
    });
    return instance;
}
- (void)setupWebViewWithCompletion:(void (^)(void))completion {
    self.tempUAWebView = [[WKWebView alloc] init];
    [self.tempUAWebView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *uaStr = result;
        if ([uaStr containsString:@"zhugeapp/"]) {
        } else {
            NSString *zhugeUA = [NSString stringWithFormat:@" zhugeapp/%@", [UUaksBJUtility appVersion]];
            NSString *newUserAgent = [uaStr stringByAppendingString:zhugeUA];
            if (newUserAgent) {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : newUserAgent}];                
            } else {
                [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent" : zhugeUA}];
            }
        }
        [WSKggBJWebViewCacheHelper removeAllCache];
        if (completion) {
            completion();
        }
    }];
}
@end
