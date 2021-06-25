#import <UIKit/UIKit.h>
typedef BOOL(^HTDatePickerEnterBlock)(NSDate *date);
@interface KSasxHTDatePickerView : UIView
+ (void)taoshowWithWithDate:(NSDate *)date
        didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock;
@end
