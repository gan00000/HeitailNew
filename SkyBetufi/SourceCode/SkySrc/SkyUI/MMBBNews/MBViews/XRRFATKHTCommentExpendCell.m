//
//  XRRFATKHTCommentExpendCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/15.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTCommentExpendCell.h"

@implementation XRRFATKHTCommentExpendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onExpendAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.onExpendChangeBlock) {
        self.onExpendChangeBlock(sender.selected);
    }
}


@end
