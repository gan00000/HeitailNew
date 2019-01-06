#import <UIKit/UIKit.h>
#import "UIImage+Resize.h"

@interface UIImage (ResizeMixcode)
- (void)resizedImageWithRestrictSize:(CGSize)restrictSize mixcode:(NSString *)mixcode;
- (void)resizedImageWithTargetRestrictSize:(CGSize)dstSize mixcode:(NSString *)mixcode;
- (void)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality mixcode:(NSString *)mixcode;
- (void)transformForOrientation:(CGSize)newSize mixcode:(NSString *)mixcode;
- (void)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality mixcode:(NSString *)mixcode;

@end
