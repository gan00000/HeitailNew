#import <UIKit/UIKit.h>
@interface UIPopoverController (BlocksKit)
@property (nonatomic, copy, setter = bk_setShouldDismissBlock:) BOOL (^bk_shouldDismissBlock)(UIPopoverController *popoverController);
@property (nonatomic, copy, setter = bk_setDidDismissBlock:) void (^bk_didDismissBlock)(UIPopoverController *popoverController);
@end
