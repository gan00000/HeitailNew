#import <Foundation/Foundation.h>
#import "HBBJWebViewInitializer.h"
#import <WebKit/WebKit.h>
#import "HBBJUtility.h"
#import "HBBJWebViewCacheHelper.h"

@interface HBBJWebViewInitializer (Mixcode)
+ (void)sharedInstanceMixcode:(NSString *)mixcode;
- (void)setupWebViewWithCompletion:(void (^)(void))completion mixcode:(NSString *)mixcode;

@end
