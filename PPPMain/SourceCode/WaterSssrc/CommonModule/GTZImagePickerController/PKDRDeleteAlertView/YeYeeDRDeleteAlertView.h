#import <UIKit/UIKit.h>
typedef void (^DRNoteTagDeleteAlertViewCompleteBlock)(BOOL isDelete);
@interface YeYeeDRDeleteAlertView : UIView
+ (void)showDeleteAlertViewWithComplete:(DRNoteTagDeleteAlertViewCompleteBlock)complete;
+ (void)showTagDeleteAlertViewWithComplete:(DRNoteTagDeleteAlertViewCompleteBlock)complete;
+ (void)showWithTitle:(NSString *)title message:(NSString *)message content:(NSString *)content complete:(DRNoteTagDeleteAlertViewCompleteBlock)complete;
@end
