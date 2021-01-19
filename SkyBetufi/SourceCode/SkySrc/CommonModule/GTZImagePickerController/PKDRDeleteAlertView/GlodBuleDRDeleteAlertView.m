#import "GlodBuleDRDeleteAlertView.h"
@interface GlodBuleDRDeleteAlertView ()
@property (weak, nonatomic) IBOutlet JXAlertContainerView *containerView;
@property (nonatomic, copy) DRNoteTagDeleteAlertViewCompleteBlock completeBlock;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHieght;
@end
@implementation GlodBuleDRDeleteAlertView
- (instancetype)init {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    if (self) {
        [self setFrame:[UIScreen mainScreen].bounds];
    }
    return self;
}
+ (void)showDeleteAlertViewWithComplete:(DRNoteTagDeleteAlertViewCompleteBlock)complete {
    [GlodBuleDRDeleteAlertView showWithTitle:@"删除" message:@"确定是否删除？" content:nil complete:complete];
}
+ (void)showTagDeleteAlertViewWithComplete:(DRNoteTagDeleteAlertViewCompleteBlock)complete {
    [self showWithTitle:@"警告" message:@"确定是否删除？" content:@"若删除此标签，则此标签下的 所有记事将不再有该标签" complete:complete];
}
+ (void)showWithTitle:(NSString *)title message:(NSString *)message content:(NSString *)content complete:(DRNoteTagDeleteAlertViewCompleteBlock)complete {
    GlodBuleDRDeleteAlertView *alertView = [[GlodBuleDRDeleteAlertView alloc] init];
    alertView.titleLabel.text = title;
    alertView.messageLabel.text = message;
    if (content.length) {
        alertView.contentLabel.text = content;
        alertView.containerViewHieght.constant = 225.0;
    } else {
        alertView.contentLabel.hidden = YES;
        alertView.containerViewHieght.constant = 180.0;
    }
    alertView.completeBlock = complete;
    [alertView show];
    [kWindow addSubview:alertView];
}
#pragma mark - Private Method
- (void)show {
    [UIView animateWithDuration:DRGlobalAnimationDuration animations:^{
        self.layer.opacity = 1.0;
    }];
    [self.containerView popToShow];
}
- (void)dismiss {
    [UIView animateWithDuration:DRGlobalAnimationDuration animations:^{
        self.layer.opacity = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    [self.containerView popToDismiss];
}
#pragma mark - Event Response
- (IBAction)cancelAction:(UIButton *)sender {
    self.completeBlock ? self.completeBlock(NO) : nil;
    [self dismiss];
}
- (IBAction)enterAction:(UIButton *)sender {
     self.completeBlock ? self.completeBlock(YES) : nil;
    [self dismiss];
}
@end
