#import <UIKit/UIKit.h>
@interface UIAlertView (BlocksKit)
+ (UIAlertView*)bk_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;
+ (id)bk_alertViewWithTitle:(NSString *)title;
+ (id)bk_alertViewWithTitle:(NSString *)title message:(NSString *)message;
- (id)bk_initWithTitle:(NSString *)title message:(NSString *)message NS_REPLACES_RECEIVER;
- (NSInteger)bk_addButtonWithTitle:(NSString *)title handler:(void (^)(void))block;
- (NSInteger)bk_setCancelButtonWithTitle:(NSString *)title handler:(void (^)(void))block;
- (void)bk_setHandler:(void (^)(void))block forButtonAtIndex:(NSInteger)index;
- (void (^)(void))bk_handlerForButtonAtIndex:(NSInteger)index;
@property (nonatomic, copy, setter = bk_setCancelBlock:) void (^bk_cancelBlock)(void);
@property (nonatomic, copy, setter = bk_setWillShowBlock:) void (^bk_willShowBlock)(UIAlertView *alertView);
@property (nonatomic, copy, setter = bk_setDidShowBlock:) void (^bk_didShowBlock)(UIAlertView *alertView);
@property (nonatomic, copy, setter = bk_setWillDismissBlock:) void (^bk_willDismissBlock)(UIAlertView *alertView, NSInteger buttonIndex);
@property (nonatomic, copy, setter = bk_setDidDismissBlock:) void (^bk_didDismissBlock)(UIAlertView *alertView, NSInteger buttonIndex);
@property (nonatomic, copy, setter = bk_SetShouldEnableFirstOtherButtonBlock:) BOOL (^bk_shouldEnableFirstOtherButtonBlock)(UIAlertView *alertView) NS_AVAILABLE_IOS(5_0);
@end
