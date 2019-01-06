#import <Foundation/Foundation.h>
@interface NSString (JXSize)
- (CGFloat)jx_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat)jx_widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
- (CGSize)jx_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize)jx_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;
+ (NSString *)jx_reverseString:(NSString *)strSrc;
@end
