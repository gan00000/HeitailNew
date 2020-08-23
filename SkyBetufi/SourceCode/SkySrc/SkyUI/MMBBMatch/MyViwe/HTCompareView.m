//
//  HTCompareView.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/8/23.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "HTCompareView.h"
#import <Masonry.h>
#import "UIColor+Hex.h"

@implementation HTCompareView
{
    UIView *leftBgView;
     UIView *rightBgView;
     UIView *leftView;
     UIView *rightView;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addMyView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addMyView];
    }
    return self;
}

-(void)addMyView
{
    
    leftBgView = [[UIView alloc] init];
    rightBgView = [[UIView alloc] init];
    leftBgView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    rightBgView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    
    [self addSubview:leftBgView];
    [leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self);
        make.leading.mas_equalTo(self);
        make.trailing.mas_equalTo(self.mas_centerX).offset(-20);
    }];
    
     [self addSubview:rightBgView];
    
    [rightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(self);
        make.leading.mas_equalTo(self.mas_centerX).offset(20);
           make.trailing.mas_equalTo(self.mas_trailing);
       }];
       
    
    leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor colorWithHexString:@"608FD4"];
    [self addSubview:leftView];
       
       [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.height.mas_equalTo(leftBgView);
              make.trailing.mas_equalTo(leftBgView);
           make.width.mas_equalTo(leftBgView).multipliedBy(0);
          }];
    
    rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor colorWithHexString:@"F35930"];
    [self addSubview:rightView];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(rightBgView);
           make.leading.mas_equalTo(rightBgView);
        make.width.mas_equalTo(rightBgView).multipliedBy(0);
       }];
    
}

-(void) updateWithLeftValue:(float)leftValue rightValue:(float) rightValue
{
    if (leftValue == 0 && rightValue == 0) {
        return;
    }
    float xxleft = leftValue / (leftValue + rightValue);
    float xxright = 1 - xxleft;
    
    [leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.height.mas_equalTo(leftBgView);
                 make.trailing.mas_equalTo(leftBgView);
              make.width.mas_equalTo(leftBgView).multipliedBy(xxleft);
             }];
    
    
    [rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(rightBgView);
        make.leading.mas_equalTo(rightBgView);
     make.width.mas_equalTo(rightBgView).multipliedBy(xxright);
    }];
    
    [self setNeedsLayout];
}

-(void) updateWithLeftPercent:(float)leftPercent rightPercent:(float) rightPercent
{
    
    [leftView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.height.mas_equalTo(leftBgView);
                 make.trailing.mas_equalTo(leftBgView);
              make.width.mas_equalTo(leftBgView).multipliedBy(leftPercent);
             }];
    
    
    [rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(rightBgView);
        make.leading.mas_equalTo(rightBgView);
     make.width.mas_equalTo(rightBgView).multipliedBy(rightPercent);
    }];
    
    [self setNeedsLayout];
}

@end
