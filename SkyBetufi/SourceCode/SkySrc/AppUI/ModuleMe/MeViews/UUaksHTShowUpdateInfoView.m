//
//  UUaksHTShowUpdateInfoView.m
//  SunFunly
//
//  Created by ganyuanrong on 2021/5/20.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "UUaksHTShowUpdateInfoView.h"

@interface UUaksHTShowUpdateInfoView()

@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *showContentInfoLabel;

@end

@implementation UUaksHTShowUpdateInfoView


+ (void)showWithData:(MMoogHTUpdateInfoModel *)model {
    UUaksHTShowUpdateInfoView *alertView = kLoadXibWithName(NSStringFromClass([self class]));
    alertView.infoModel = model;
    [alertView show];
}

-(void)show{
    self.frame = kDRWindow.bounds;
    [kDRWindow addSubview:self];
    
    self.infoView.layer.cornerRadius = 8;
    self.infoView.clipsToBounds = YES;
    
    self.showContentInfoLabel.text = self.infoModel.content;
}

- (IBAction)updateInfoCancelAction:(id)sender {
    
    [self dismiss];
}

- (IBAction)updateInfoOkAction:(id)sender {
    
    NSString *webUrl = self.infoModel.confirm_to;
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrl] options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrl]];
    }
//    [self dismiss];
}


- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor clearColor];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
