#import <Foundation/Foundation.h>
@interface SkyBallHetiRedHTHtmlLoadUtil : NSObject
+ (instancetype)sharedInstance;
- (NSString *)svgHtmlWithUrl:(NSString *)img_url width:(NSInteger)width;
- (NSString *)iframHtmlWithContent:(NSString *)iframe_content;
@end
