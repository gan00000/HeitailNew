#import <Foundation/Foundation.h>
@interface XRRFATKBJWebViewInitializer : NSObject
+ (instancetype)sharedInstance;
- (void)setupWebViewWithCompletion:(void(^)(void))completion;
@end
