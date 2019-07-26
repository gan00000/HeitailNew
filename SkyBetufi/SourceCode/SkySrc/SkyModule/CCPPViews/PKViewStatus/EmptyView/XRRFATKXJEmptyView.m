//
//  XRRFATKXJEmptyView.m
//  Exchange
//
//  Created by Marco on 2017/3/7.
//  Copyright © 2017年 zhugelicai. All rights reserved.
//

#import "XRRFATKXJEmptyView.h"

@implementation XRRFATKXJEmptyView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    //self.backgroundColor = [UIColor whiteColor];
    self.contentLabel.textColor = RGBA_COLOR_HEX(0x666666);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapAction)];
    [self.contentLabel addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentTapAction)];
    [self.imageView addGestureRecognizer:tap1];
}

- (void)contentTapAction {
    if (self.contentTapBlock) {
        self.contentTapBlock();
    }
}

@end
