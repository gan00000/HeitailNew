#import <UIKit/UIKit.h>
@interface UIImage (Resize)
- (UIImage *)resizedImageWithRestrictSize:(CGSize)size;
- (UIImage *)resizedImageWithTargetRestrictSize:(CGSize)dstSize;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
@end
