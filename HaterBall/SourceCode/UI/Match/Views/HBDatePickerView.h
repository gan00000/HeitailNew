#import <UIKit/UIKit.h>
typedef BOOL(^HTDatePickerEnterBlock)(NSDate *date);
@interface HBDatePickerView : UIView
+ (void)showWithWithDate:(NSDate *)date
        didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock;
@end
