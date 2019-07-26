//
//  XRRFATKHTNewsTopHeaderView.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTNewsTopHeaderView.h"

@interface XRRFATKHTNewsTopHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation XRRFATKHTNewsTopHeaderView

- (void)refreshWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
