#import "TZPhotoPickerController+GlodBuleDRExtention.h"
#import <AVFoundation/AVFoundation.h>
@implementation GlodBuleTZPhotoPickerController (SkyBallHetiRedDRExtention)
- (void)takePhoto {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        [self openCamera];
    } else if (status == AVAuthorizationStatusDenied) {
        [GlodBuleHTUserManager waterSkycameraDenied];
    } else {
        kWeakSelf
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    [weakSelf openCamera];
                }
            });
        }];
    }
}
- (void)openCamera {
    [self performSelector:@selector(pushImagePickerController) withObject:nil afterDelay:NO];
}
@end
