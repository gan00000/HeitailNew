#import <Foundation/Foundation.h>
@interface GlodBuleBJServiceConfigurator : NSObject
+ (instancetype)sharedInstance;
- (void)connectToServer;
- (NSString *)serverBaseUrl;
- (NSString *)h5BaseUrl;
- (void)waterSky_switchToProductServer;
- (void)waterSky_switchToTestServer;
- (void)waterSky_switchToDevServer;
- (NSInteger)waterSky_currentServerType; 
@end
