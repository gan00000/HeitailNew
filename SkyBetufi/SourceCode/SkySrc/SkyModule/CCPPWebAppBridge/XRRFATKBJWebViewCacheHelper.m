#import "XRRFATKBJWebViewCacheHelper.h"
#import "XRRFATKBJUtility.h"
#import <WebKit/WebKit.h>
@implementation XRRFATKBJWebViewCacheHelper
+ (void)removeAllCache {
    if ([XRRFATKBJUtility systemVersion].floatValue >= 9) {
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] modifiedSince:dateFrom completionHandler:^{
            BJLog(@"WKWebsiteDataStore remove cache");
        }];
    } else {
        NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString *cookiesFolder = [libPath stringByAppendingString:@"/Cookies"];
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolder error:&error];
        if (error) {
            BJLog(@"XRRFATKBJWebViewController remove cookies error = %@", error);
        }
    }
}
@end