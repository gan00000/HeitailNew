#import <Foundation/Foundation.h>
@interface SkyBallHetiRedBJWebViewInitializer : NSObject
+ (instancetype)sharedInstance;
- (void)setupWebViewWithCompletion:(void(^)(void))completion;
@end
