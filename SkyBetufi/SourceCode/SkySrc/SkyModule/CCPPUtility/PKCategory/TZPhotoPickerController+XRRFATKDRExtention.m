#import "TZPhotoPickerController+XRRFATKDRExtention.h"
#import <AVFoundation/AVFoundation.h>
@implementation XRRFATKTZPhotoPickerController (XRRFATKDRExtention)
- (void)takePhoto {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        [self openCamera];
    } else if (status == AVAuthorizationStatusDenied) {
        [XRRFATKHTUserManager skargcameraDenied];
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
