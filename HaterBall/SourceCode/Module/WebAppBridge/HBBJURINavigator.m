#import "HBBJURINavigator.h"
typedef void (^BJURIHandlerBlock)(NSString *uri, NSString *baseUrl, NSDictionary *parms);
@interface HBBJURINavigator ()
@property (nonatomic, strong) NSMutableDictionary *uriHandlerDict;
@end
@implementation HBBJURINavigator
+ (instancetype)sharedInstance {
    static HBBJURINavigator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HBBJURINavigator alloc] init];
        [instance registerAll];
    });
    return instance;
}
- (BOOL)canHandleURI:(NSString *)uri {
    NSString *key = uri;
    if ([uri containsString:@"?"]) {
        key = [uri componentsSeparatedByString:@"?"][0];
    }
    if (self.uriHandlerDict[key]) {
        return YES;
    }
    return NO;
}
- (BOOL)handleURI:(NSString *)uri {
    BOOL hasParams = NO;
    NSString *key = uri;
    if ([uri containsString:@"?"]) {
        hasParams = YES;
        key = [uri componentsSeparatedByString:@"?"][0];
    }
    if (self.uriHandlerDict[key]) {
        NSMutableDictionary *parms = [NSMutableDictionary dictionary];
        if (hasParams) {
            NSURLComponents *components = [NSURLComponents componentsWithString:uri];
            for(NSURLQueryItem *item in components.queryItems) {
                parms[item.name] = item.value;
            }
        }
        BJURIHandlerBlock block = self.uriHandlerDict[key];
        block(uri, key, parms);
        return YES;
    }
    return NO;
}
- (void)registerURI:(NSString *)uri handleBlock:(BJURIHandlerBlock)handleBlock {
    NSString *key = uri;
    if ([uri containsString:@"?"]) { 
        key = [uri componentsSeparatedByString:@"?"][0]; 
    }
    self.uriHandlerDict[key] = handleBlock;
}
#pragma mark -
- (NSMutableDictionary *)uriHandlerDict {
    if (!_uriHandlerDict) {
        _uriHandlerDict = [[NSMutableDictionary alloc] init];
    }
    return _uriHandlerDict;
}
#pragma mark - 
- (void)registerAll {
}
@end
