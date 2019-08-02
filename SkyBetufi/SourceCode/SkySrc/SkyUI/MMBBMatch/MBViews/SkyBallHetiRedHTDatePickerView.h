#import <UIKit/UIKit.h>
typedef BOOL(^HTDatePickerEnterBlock)(NSDate *date);
@interface SkyBallHetiRedHTDatePickerView : UIView
+ (void)waterSkyshowWithWithDate:(NSDate *)date
        didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock;
@end
