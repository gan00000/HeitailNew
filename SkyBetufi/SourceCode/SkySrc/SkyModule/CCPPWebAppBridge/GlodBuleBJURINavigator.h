#import <Foundation/Foundation.h>
static NSString * const BJURIScheme = @"zglc";
@interface GlodBuleBJURINavigator : NSObject
+ (instancetype)sharedInstance;
- (BOOL)canHandleURI:(NSString *)uri;
- (BOOL)handleURI:(NSString *)uri;
@end
