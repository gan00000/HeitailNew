#import "HBDatePickerView.h"
static const CGFloat HTDatePickerHeight = 245.0;
@interface HBDatePickerView ()
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *containerViewBottom;
@property (copy, nonatomic) HTDatePickerEnterBlock enterBlock;
@end
@implementation HBDatePickerView
- (instancetype)init {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    if (self) {
    }
    return self;
}
+ (void)showWithWithDate:(NSDate *)date didTapEnterBlock:(HTDatePickerEnterBlock)enterBlock {
    HBDatePickerView *datePicker = [[HBDatePickerView alloc] init];
    datePicker.frame = [UIScreen mainScreen].bounds;
    if (date) {
        datePicker.datePicker.date = date;
    }
    datePicker.enterBlock = enterBlock;
    [datePicker show];
    [kWindow addSubview:datePicker];
}
- (void)show {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.containerViewBottom.constant = 0;
        [self layoutIfNeeded];
    } completion:nil];
}
- (void)dismiss {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containerViewBottom.constant = -HTDatePickerHeight;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark -
- (IBAction)enterAction:(id)sender {
    if (self.enterBlock) {
        BOOL canDismiss = self.enterBlock(self.datePicker.date);
        canDismiss ? [self dismiss] : nil;
    } else {
        [self dismiss];
    }
}
- (IBAction)cancelAction:(id)sender {
    [self dismiss];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}
@end
