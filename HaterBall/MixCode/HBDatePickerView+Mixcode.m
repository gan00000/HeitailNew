#import "HBDatePickerView+Mixcode.h"
@implementation HBDatePickerView (Mixcode)
- (void)initMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)showWithWithDate:(NSDate *)date didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)showMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)dismissMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)enterAction:(id)sender mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)cancelAction:(id)sender mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
