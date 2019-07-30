#import <Foundation/Foundation.h>
@interface XRRFATKBJServiceConfigurator : NSObject
+ (instancetype)sharedInstance;
- (void)connectToServer;
- (NSString *)serverBaseUrl;
- (NSString *)h5BaseUrl;
- (void)skarg_switchToProductServer;
- (void)skarg_switchToTestServer;
- (void)skarg_switchToDevServer;
- (NSInteger)skarg_currentServerType; 
@end
