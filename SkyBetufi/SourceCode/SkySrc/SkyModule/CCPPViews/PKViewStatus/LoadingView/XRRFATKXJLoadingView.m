//
//  XRRFATKXJLoadingView.m
//  Exchange
//
//  Created by Marco on 2017/3/7.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import "XRRFATKXJLoadingView.h"

@interface XRRFATKXJLoadingView ()

@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;


@end

@implementation XRRFATKXJLoadingView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    animation.duration = 2.0f;
    animation.repeatCount = HUGE_VAL;
    [self.progressImageView.layer addAnimation:animation forKey:@"XRRFATKBJHUDView"];
}

@end
