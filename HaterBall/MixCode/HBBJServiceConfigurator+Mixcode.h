#import <Foundation/Foundation.h>
#import "HBBJServiceConfigurator.h"

@interface HBBJServiceConfigurator (Mixcode)
+ (void)sharedInstanceMixcode:(NSString *)mixcode;
- (void)connectToServerMixcode:(NSString *)mixcode;
- (void)serverBaseUrlMixcode:(NSString *)mixcode;
- (void)h5BaseUrlMixcode:(NSString *)mixcode;
- (void)switchToProductServerMixcode:(NSString *)mixcode;
- (void)switchToTestServerMixcode:(NSString *)mixcode;
- (void)switchToDevServerMixcode:(NSString *)mixcode;
- (void)currentServerTypeMixcode:(NSString *)mixcode;

@end
