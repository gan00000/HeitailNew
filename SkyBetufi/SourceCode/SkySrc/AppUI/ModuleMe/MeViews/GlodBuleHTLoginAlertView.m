#import "GlodBuleHTLoginAlertView.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import <Masonry.h>

@interface GlodBuleHTLoginAlertView ()
@property (weak, nonatomic) IBOutlet UIView *safeBackView;
@property (weak, nonatomic) IBOutlet UIButton *lineLoginBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewBottom;
@property (weak, nonatomic) IBOutlet JXImageView *lineLoginImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *saveView;

@property (nonatomic, copy) void (^onPlatformButtonTapped)(HTLoginPlatform platform);
@end
@implementation GlodBuleHTLoginAlertView
+ (void)taoshowLoginAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block {
    GlodBuleHTLoginAlertView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.onPlatformButtonTapped = block;
    [alertView show:YES];
}
+ (void)taoshowShareAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block {
    GlodBuleHTLoginAlertView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.titleLabel.text = @"分享至";
    alertView.onPlatformButtonTapped = block;
    [alertView show:NO];
}

+ (void)taoshowShareAlertViewWithFB:(void(^)(HTLoginPlatform platform))block {
    GlodBuleHTLoginAlertView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.titleLabel.text = @"分享至";
    alertView.onPlatformButtonTapped = block;
//    alertView.lineLoginBtn.hidden = YES;
//    alertView.lineLoginImageView.hidden = YES;
    alertView.lineView.hidden = YES;
    [alertView show:NO];
}

+ (void)taoshowShareAlertViewWithFBAndSave:(void(^)(HTLoginPlatform platform))block {
    GlodBuleHTLoginAlertView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.titleLabel.text = @"分享至";
    alertView.onPlatformButtonTapped = block;
//    alertView.lineLoginBtn.hidden = YES;
//    alertView.lineLoginImageView.hidden = YES;
    alertView.lineView.hidden = YES;
    alertView.saveView.hidden = NO;
    [alertView show:NO];
}

- (void)show:(Boolean) isLogin {
    self.frame = kDRWindow.bounds;
    [kDRWindow addSubview:self];
    
    if (isLogin) {
        if (@available(iOS 13.0, *)) {
            ASAuthorizationAppleIDButton *appleBtn = [[ASAuthorizationAppleIDButton alloc] initWithAuthorizationButtonType:(ASAuthorizationAppleIDButtonTypeSignIn) authorizationButtonStyle:(ASAuthorizationAppleIDButtonStyleWhiteOutline)];
           
           [appleBtn addTarget:self action:@selector(appleIdLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
           
            [self addSubview:appleBtn];
            [appleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.lineLoginBtn.mas_trailing).mas_offset(5);
                make.width.mas_equalTo(60);
               make.top.bottom.mas_equalTo(self.lineLoginImageView);
            }];

            
            GIDSignInButton *gidSignInBtn = [[GIDSignInButton alloc] init];
            [self addSubview:gidSignInBtn];
            [gidSignInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(appleBtn.mas_trailing).mas_offset(5);
                make.width.mas_equalTo(60);
               make.top.bottom.mas_equalTo(self.lineLoginImageView);
            }];
            [gidSignInBtn addTarget:self action:@selector(gidLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            
            GIDSignInButton *gidSignInBtn = [[GIDSignInButton alloc] init];
            [self addSubview:gidSignInBtn];
            [gidSignInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self.lineLoginBtn.mas_trailing).mas_offset(10);
                make.width.mas_equalTo(100);
               make.top.bottom.mas_equalTo(self.lineLoginImageView);
            }];
            [gidSignInBtn addTarget:self action:@selector(gidLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    

    [UIView performWithoutAnimation:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.containerViewBottom.constant = - (self.containerViewHeight.constant + [UITabBar safeHeight]);
        [self layoutIfNeeded];
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.containerViewBottom.constant = 0;
        [self layoutIfNeeded];
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containerViewBottom.constant = - (self.containerViewHeight.constant + [UITabBar safeHeight]);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    if (!CGRectContainsPoint(self.safeBackView.frame, loc)) {
        [self dismiss];
    }
}
- (IBAction)loginAction:(UIButton *)sender {
    if (self.onPlatformButtonTapped) {
        self.onPlatformButtonTapped(sender.tag);
    }
    [self dismiss];
}

- (void)appleIdLoginBtn:(UIButton *)sender {
    
    if (self.onPlatformButtonTapped) {
        self.onPlatformButtonTapped(HTLoginPlatformAppleId);
    }
    [self dismiss];
}

- (void)gidLoginBtn:(UIButton *)sender {
    
    if (self.onPlatformButtonTapped) {
        self.onPlatformButtonTapped(HTLoginPlatformGid);
    }
    [self dismiss];
}

@end
