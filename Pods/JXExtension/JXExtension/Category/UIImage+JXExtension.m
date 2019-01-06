#import "UIImage+JXExtension.h"
@implementation UIImage (JXExtension)
+ (UIImage *)jx_launchImage {
    NSString *launchImage;
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";
    NSArray *imageDictionarys = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dictionary in imageDictionarys) {
        CGSize imageSize = CGSizeFromString(dictionary[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dictionary[@"UILaunchImageOrientation"]])
            launchImage = dictionary[@"UILaunchImageName"];
    }
    return [UIImage imageNamed:launchImage];
}
+ (UIImage *)jx_imageWithView:(UIView *)view {
    if (!view) {
        return [[UIImage alloc] init];
    }
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)jx_imageWithColor:(UIColor *)color {
    return [self jx_imageWithColor:color size:CGSizeMake(1.0, 1.0)];
}
+ (UIImage *)jx_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color) {
        return [[UIImage alloc] init];
    }
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIColor *)jx_colorAtPixel:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0, 0.0, self.size.width, self.size.height), point)) {
        return nil;
    }
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextTranslateCTM(context, -pointX, pointY - (CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    CGFloat red = (CGFloat)pixelData[0] / 255.0;
    CGFloat green = (CGFloat)pixelData[1] / 255.0;
    CGFloat blue = (CGFloat)pixelData[2] / 255.0;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
- (BOOL)jx_hasAlphaChannel {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
@end
