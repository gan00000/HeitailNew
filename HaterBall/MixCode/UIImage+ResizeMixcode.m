#import "UIImage+ResizeMixcode.h"
@implementation UIImage (ResizeMixcode)
- (void)resizedImageWithRestrictSize:(CGSize)restrictSize mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)resizedImageWithTargetRestrictSize:(CGSize)dstSize mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)transformForOrientation:(CGSize)newSize mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
