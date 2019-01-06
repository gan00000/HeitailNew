#import <Foundation/Foundation.h>
@interface HBBJWebViewInitializer : NSObject
+ (instancetype)sharedInstance;
- (void)setupWebViewWithCompletion:(void(^)(void))completion;
@end
