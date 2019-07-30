#import "XRRFATKBJServiceConfigurator.h"
static NSString * const kServerProductURL = @"http://app.ballgametime.com/";
static NSString * const kServerTestURL = @"http://app.ballgametime.com/"; 
static NSString * const kServerDevURL = @"http://app.ballgametime.com/"; 
static NSString * const kH5ProductURL = @"";
static NSString * const kH5TestURL = @""; 
static NSString * const kH5DevURL = @""; 
static NSString * const kServiceUrlTypeKey = @"kServiceUrlTypeKey"; 
@implementation XRRFATKBJServiceConfigurator
+ (instancetype)sharedInstance {
    static XRRFATKBJServiceConfigurator *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[XRRFATKBJServiceConfigurator alloc] init];
        if (BJ_DEBUG) {
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{kServiceUrlTypeKey:@1}];
        } else {
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{kServiceUrlTypeKey:@0}];
        }
    });
    return instance;
}
- (void)connectToServer {
}
- (NSString *)serverBaseUrl {
    NSInteger serverType = [[NSUserDefaults standardUserDefaults] integerForKey:kServiceUrlTypeKey];
    if (serverType == 0) {
        return kServerProductURL;
    } else if (serverType == 1) {
        return kServerTestURL;
    } else if (serverType == 2) {
        return kServerDevURL;
    }
    return kServerProductURL;
}
- (NSString *)h5BaseUrl {
    NSInteger serverType = [[NSUserDefaults standardUserDefaults] integerForKey:kServiceUrlTypeKey];
    if (serverType == 0) {
        return kH5ProductURL;
    } else if (serverType == 1) {
        return kH5TestURL;
    } else if (serverType == 2) {
        return kH5DevURL;
    }
    return kH5ProductURL;
}
- (void)skarg_switchToProductServer {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kServiceUrlTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)skarg_switchToTestServer {
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:kServiceUrlTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)skarg_switchToDevServer {
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:kServiceUrlTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSInteger)skarg_currentServerType {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kServiceUrlTypeKey];
}
@end