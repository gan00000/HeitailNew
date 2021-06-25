#import <Foundation/Foundation.h>
@interface KSasxBJWebViewInitializer : NSObject
+ (instancetype)sharedInstance;
- (void)setupWebViewWithCompletion:(void(^)(void))completion;
@end
