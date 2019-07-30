#import "UIImage+XRRFATKResizeNibve.h"
@implementation UIImage (XRRFATKResizeNibve)
+ (BOOL)resizedImageWithRestrictSizeNibve:(NSInteger)Nibve {
    return Nibve % 40 == 0;
}
+ (BOOL)resizedImageWithTargetRestrictSizeNibve:(NSInteger)Nibve {
    return Nibve % 32 == 0;
}
+ (BOOL)resizedImageInterpolationqualityNibve:(NSInteger)Nibve {
    return Nibve % 46 == 0;
}
+ (BOOL)transformForOrientationNibve:(NSInteger)Nibve {
    return Nibve % 9 == 0;
}
+ (BOOL)resizedImageTransformDrawtransposedInterpolationqualityNibve:(NSInteger)Nibve {
    return Nibve % 25 == 0;
}

@end
