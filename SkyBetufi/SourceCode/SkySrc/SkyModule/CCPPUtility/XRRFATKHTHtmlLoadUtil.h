#import <Foundation/Foundation.h>
@interface XRRFATKHTHtmlLoadUtil : NSObject
+ (instancetype)sharedInstance;
- (NSString *)svgHtmlWithUrl:(NSString *)img_url width:(NSInteger)width;
- (NSString *)iframHtmlWithContent:(NSString *)iframe_content;
@end
