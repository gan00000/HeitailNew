//
//  XRRFATKBJHUDView.m
//  BenjiaPro
//
//  Created by Marco on 2017/6/30.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKBJHUDView.h"

@interface XRRFATKBJHUDView ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *progressImageView;

@end

@implementation XRRFATKBJHUDView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.layer.cornerRadius = 3;
    self.contentView.layer.shadowOffset = CGSizeMake(1, -2);
    self.contentView.layer.shadowRadius = 5;
    self.contentView.layer.shadowColor = RGBA_COLOR_HEX(0x666666).CGColor;
    self.contentView.layer.shadowOpacity = 0.5;
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
    animation.duration = 2.0f;
    animation.repeatCount = HUGE_VAL;
    [self.progressImageView.layer addAnimation:animation forKey:@"XRRFATKBJHUDView"];
    
}

@end
