#import <UIKit/UIKit.h>
typedef BOOL(^HTDatePickerEnterBlock)(NSDate *date);
@interface XRRFATKHTDatePickerView : UIView
+ (void)skargshowWithWithDate:(NSDate *)date
        didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock;
@end
