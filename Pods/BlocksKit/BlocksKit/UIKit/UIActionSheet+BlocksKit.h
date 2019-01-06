#import <UIKit/UIKit.h>
@interface UIActionSheet (BlocksKit) <UIActionSheetDelegate>
+ (id)bk_actionSheetWithTitle:(NSString *)title;
- (id)bk_initWithTitle:(NSString *)title NS_REPLACES_RECEIVER;
- (NSInteger)bk_addButtonWithTitle:(NSString *)title handler:(void (^)(void))block;
- (NSInteger)bk_setDestructiveButtonWithTitle:(NSString *)title handler:(void (^)(void))block;
- (NSInteger)bk_setCancelButtonWithTitle:(NSString *)title handler:(void (^)(void))block;
- (void)bk_setHandler:(void (^)(void))block forButtonAtIndex:(NSInteger)index;
- (void (^)(void))bk_handlerForButtonAtIndex:(NSInteger)index;
@property (nonatomic, copy, setter = bk_setCancelBlock:) void (^bk_cancelBlock)(void);
@property (nonatomic, copy, setter = bk_setWillShowBlock:) void (^bk_willShowBlock)(UIActionSheet *actionSheet);
@property (nonatomic, copy, setter = bk_setDidShowBlock:) void (^bk_didShowBlock)(UIActionSheet *actionSheet);
@property (nonatomic, copy, setter = bk_setWillDismissBlock:) void (^bk_willDismissBlock)(UIActionSheet *actionSheet, NSInteger buttonIndex);
@property (nonatomic, copy, setter = bk_setDidDismissBlock:) void (^bk_didDismissBlock)(UIActionSheet *actionSheet, NSInteger buttonIndex);
@end
