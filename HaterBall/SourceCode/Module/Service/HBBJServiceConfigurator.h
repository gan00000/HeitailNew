#import <Foundation/Foundation.h>
@interface HBBJServiceConfigurator : NSObject
+ (instancetype)sharedInstance;
- (void)connectToServer;
- (NSString *)serverBaseUrl;
- (NSString *)h5BaseUrl;
- (void)switchToProductServer;
- (void)switchToTestServer;
- (void)switchToDevServer;
- (NSInteger)currentServerType; 
@end
