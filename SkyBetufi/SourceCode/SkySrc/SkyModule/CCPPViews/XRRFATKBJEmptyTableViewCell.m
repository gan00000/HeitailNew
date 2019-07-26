//
//  XRRFATKBJEmptyTableViewCell.m
//  BenjiaPro
//
//  Created by Marco on 2017/6/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKBJEmptyTableViewCell.h"
#import "UIView+XRRFATKEmptyView.h"

@implementation XRRFATKBJEmptyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self showEmptyView];
    
}

@end
