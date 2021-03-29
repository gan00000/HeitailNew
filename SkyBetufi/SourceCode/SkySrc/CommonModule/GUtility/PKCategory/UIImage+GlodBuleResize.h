#import <UIKit/UIKit.h>
@interface UIImage (SkyBallHetiRedResize)
- (UIImage *)resizedImageWithRestrictSize:(CGSize)size;
- (UIImage *)resizedImageWithTargetRestrictSize:(CGSize)dstSize;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

-(UIImage*)scaleToSize:(CGSize)size;

-(UIImage *)clipImageInRect:(CGRect)rect;
@end
