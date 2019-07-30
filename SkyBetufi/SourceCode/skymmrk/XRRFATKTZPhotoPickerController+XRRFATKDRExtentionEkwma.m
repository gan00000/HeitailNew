#import "XRRFATKTZPhotoPickerController+XRRFATKDRExtentionEkwma.h"
@implementation XRRFATKTZPhotoPickerController (XRRFATKDRExtentionEkwma)
+ (BOOL)takePhotoEkwma:(NSInteger)Ekwma {
    return Ekwma % 19 == 0;
}
+ (BOOL)openCameraEkwma:(NSInteger)Ekwma {
    return Ekwma % 20 == 0;
}

@end
