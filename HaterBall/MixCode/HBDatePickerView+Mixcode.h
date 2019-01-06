#import <UIKit/UIKit.h>
#import "HBDatePickerView.h"

@interface HBDatePickerView (Mixcode)
- (void)initMixcode:(NSString *)mixcode;
+ (void)showWithWithDate:(NSDate *)date didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock mixcode:(NSString *)mixcode;
- (void)showMixcode:(NSString *)mixcode;
- (void)dismissMixcode:(NSString *)mixcode;
- (void)enterAction:(id)sender mixcode:(NSString *)mixcode;
- (void)cancelAction:(id)sender mixcode:(NSString *)mixcode;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event mixcode:(NSString *)mixcode;

@end
