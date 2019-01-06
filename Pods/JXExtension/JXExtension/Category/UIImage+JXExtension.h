#import <UIKit/UIKit.h>
@interface UIImage (JXExtension)
+ (UIImage *)jx_launchImage;
+ (UIImage *)jx_imageWithView:(UIView *)view;
+ (UIImage *)jx_imageWithColor:(UIColor *)color;
+ (UIImage *)jx_imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIColor *)jx_colorAtPixel:(CGPoint)point;
- (BOOL)jx_hasAlphaChannel;
@end
