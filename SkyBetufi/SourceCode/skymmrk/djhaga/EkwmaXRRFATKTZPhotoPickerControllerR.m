#import "EkwmaXRRFATKTZPhotoPickerControllerR.h"
@implementation EkwmaXRRFATKTZPhotoPickerControllerR
+ (BOOL)QtakePhoto:(NSInteger)Ekwma {
    return Ekwma % 45 == 0;
}
+ (BOOL)VopenCamera:(NSInteger)Ekwma {
    return Ekwma % 4 == 0;
}

@end
