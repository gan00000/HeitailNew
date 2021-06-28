#import <Foundation/Foundation.h>
@interface TuTuosBJServiceConfigurator : NSObject
+ (instancetype)sharedInstance;
- (void)connectToServer;
- (NSString *)serverBaseUrl;
- (NSString *)h5BaseUrl;
- (void)tao_switchToProductServer;
- (void)tao_switchToTestServer;
- (void)tao_switchToDevServer;
- (NSInteger)tao_currentServerType; 
@end
