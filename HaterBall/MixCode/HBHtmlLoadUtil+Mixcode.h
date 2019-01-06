#import <Foundation/Foundation.h>
#import "HBHtmlLoadUtil.h"

@interface HBHtmlLoadUtil (Mixcode)
+ (void)sharedInstanceMixcode:(NSString *)mixcode;
- (void)initMixcode:(NSString *)mixcode;
- (void)svgHtmlWithUrl:(NSString *)img_url width:(NSInteger)width mixcode:(NSString *)mixcode;
- (void)iframHtmlWithContent:(NSString *)iframe_content mixcode:(NSString *)mixcode;

@end
