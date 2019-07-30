#import <Foundation/Foundation.h>
static NSString * const BJURIScheme = @"zglc";
@interface XRRFATKBJURINavigator : NSObject
+ (instancetype)sharedInstance;
- (BOOL)canHandleURI:(NSString *)uri;
- (BOOL)handleURI:(NSString *)uri;
@end
