#import <UIKit/UIKit.h>
@interface UIImagePickerController (BlocksKit)
@property (nonatomic, copy) void(^bk_didFinishPickingMediaBlock)(UIImagePickerController *, NSDictionary *);
@property (nonatomic, copy) void(^bk_didCancelBlock)(UIImagePickerController *);
@end
