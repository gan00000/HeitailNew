//
//  UUaksHTIndicatorView.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/8/22.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "UUaksHTIndicatorView.h"

@implementation UUaksHTIndicatorView
{
    UIView *leftView;
    UIView *rightView;
    
    float xxleftWidth;
    float xxrightWidth;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        xxleftWidth = 0;
        xxrightWidth = 0;
        
        [self addMyView];
        
    }
    return self;
}


-(void)addMyView
{
    [self addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.5);
    }];
    
    [self addSubview:[self rightView]];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self);
        make.leading.mas_equalTo(leftView.mas_trailing);
        make.trailing.mas_equalTo(self.mas_trailing);
    }];
}

-(void)updateView:(float)leftValue rightValue:(float)rightValue
{
    if (leftValue > 0 && rightValue > 0 ) {
        xxleftWidth = leftValue / (leftValue + rightValue);
        xxrightWidth = 1-xxleftWidth;
    }else if (leftValue == 0 && rightValue > 0){
        xxleftWidth = 0;
        xxrightWidth = 1;
    }
    else if (leftValue > 0 && rightValue == 0){
        xxleftWidth = 1;
        xxrightWidth = 0;
    }else{
        xxleftWidth = 0.5;
        xxrightWidth = 0.5;
    }
    [self.leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.height.mas_equalTo(self);
         make.left.mas_equalTo(self);
         make.width.mas_equalTo(self).multipliedBy(xxleftWidth);
    }];
    [self.rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self);
        make.leading.mas_equalTo(leftView.mas_trailing);
        make.trailing.mas_equalTo(self.mas_trailing);
    }];
    [self setNeedsDisplay];
}

-(UIView *)leftView
{
    if (!leftView) {
        leftView = [[UIView alloc] init];
        leftView.backgroundColor = [UIColor colorWithHexString:@"608FD4"];
    }
    return leftView;
}

-(UIView *)rightView
{
    if (!rightView) {
        rightView = [[UIView alloc] init];
        rightView.backgroundColor = [UIColor redColor];
    }
    return rightView;
}

@end
