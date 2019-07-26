//
//  XRRFATKHTLoginAlertView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/6.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTLoginAlertView.h"

@interface XRRFATKHTLoginAlertView ()

@property (weak, nonatomic) IBOutlet UIView *safeBackView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewBottom;

@property (nonatomic, copy) void (^onPlatformButtonTapped)(HTLoginPlatform platform);

@end

@implementation XRRFATKHTLoginAlertView

+ (void)showLoginAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block {
    XRRFATKHTLoginAlertView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.onPlatformButtonTapped = block;
    [alertView show];
}

+ (void)showShareAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block {
    XRRFATKHTLoginAlertView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.titleLabel.text = @"分享至";
    alertView.onPlatformButtonTapped = block;
    [alertView show];
}

/**
 动画显示选择器
 */
- (void)show {
    self.frame = kDRWindow.bounds;
    [kDRWindow addSubview:self];
    
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

/**
 动画隐藏选择器
 */
- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containerViewBottom.constant = - (self.containerViewHeight.constant + [UITabBar safeHeight]);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**
 点击蒙板区域响应
 
 @param touches 点击区域信息
 @param event 事件
 */
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


@end
