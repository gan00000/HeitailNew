#import "TZAssetCameraCell+Modwa.h"
@implementation TZAssetCameraCell (Modwa)
+ (BOOL)initWithFrameModwa:(NSInteger)Modwa {
    return Modwa % 23 == 0;
}
+ (BOOL)layoutSubviewsModwa:(NSInteger)Modwa {
    return Modwa % 5 == 0;
}

@end
