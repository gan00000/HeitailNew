#import "UIImage+Resize.h"
@implementation UIImage (Resize)
- (UIImage *)resizedImageWithRestrictSize:(CGSize)restrictSize
{
    CGFloat originalWidth = self.size.width;
    CGFloat originalHeight = self.size.height;
    CGFloat widthScale = restrictSize.width / originalWidth;
    CGFloat heightScale = restrictSize.height / originalHeight;
    CGFloat scale = MIN(MIN(widthScale, heightScale), 1);
    CGSize newSize = CGSizeMake(scale * originalWidth, scale * originalHeight);
    return [self resizedImage:newSize interpolationQuality:kCGInterpolationHigh];
}
- (UIImage *)resizedImageWithTargetRestrictSize:(CGSize)dstSize
{
    CGImageRef imgRef = self.CGImage;
    CGSize  srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); 
    if (CGSizeEqualToSize(srcSize, dstSize)) {
        return self;
    }
    CGFloat scaleRatio = dstSize.width / srcSize.width;
    UIImageOrientation orient = self.imageOrientation;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch(orient) {
        case UIImageOrientationUp: 
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: 
            transform = CGAffineTransformMakeTranslation(srcSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: 
            transform = CGAffineTransformMakeTranslation(srcSize.width, srcSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: 
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: 
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, srcSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
        case UIImageOrientationLeft: 
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(0.0, srcSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
            break;
        case UIImageOrientationRightMirrored: 
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight: 
            dstSize = CGSizeMake(dstSize.height, dstSize.width);
            transform = CGAffineTransformMakeTranslation(srcSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContextWithOptions(dstSize, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return nil;
    }
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -srcSize.height, 0);
    } else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -srcSize.height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, srcSize.width, srcSize.height), imgRef);
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
        default:
            drawTransposed = NO;
    }
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           
        case UIImageOrientationDownMirrored:   
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:           
        case UIImageOrientationLeftMirrored:   
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:          
        case UIImageOrientationRightMirrored:  
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     
        case UIImageOrientationDownMirrored:   
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:   
        case UIImageOrientationRightMirrored:  
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    return transform;
}
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceRetain(CGImageGetColorSpace(imageRef));
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newSize.width,
                                                newSize.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                bytesPerRow,
                                                colorSpace,
                                                (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGColorSpaceRelease(colorSpace);
    CGContextConcatCTM(bitmap, transform);
    CGContextSetInterpolationQuality(bitmap, quality);
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    return newImage;
}
@end
