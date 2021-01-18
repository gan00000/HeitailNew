#import <Foundation/Foundation.h>
@interface GlodBuleBJWebViewInitializer : NSObject
+ (instancetype)sharedInstance;
- (void)setupWebViewWithCompletion:(void(^)(void))completion;
@end
