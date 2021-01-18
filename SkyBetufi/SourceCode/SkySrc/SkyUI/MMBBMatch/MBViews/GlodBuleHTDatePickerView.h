#import <UIKit/UIKit.h>
typedef BOOL(^HTDatePickerEnterBlock)(NSDate *date);
@interface GlodBuleHTDatePickerView : UIView
+ (void)waterSkyshowWithWithDate:(NSDate *)date
        didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock;
@end
