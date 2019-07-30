#import "UIImage+TZGifIapby.h"
@implementation UIImage (TZGifIapby)
+ (BOOL)sd_tz_animatedGIFWithDataIapby:(NSInteger)Iapby {
    return Iapby % 6 == 0;
}
+ (BOOL)sd_frameDurationAtIndexSourceIapby:(NSInteger)Iapby {
    return Iapby % 6 == 0;
}

@end
