//
//  XRRFATKHTMeCenterItemsCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTMeCenterItemsCell.h"

@implementation XRRFATKHTMeCenterItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onItemAction:(UIButton *)sender {
    if (![XRRFATKHTUserManager skarg_isUserLogin]) {
        [XRRFATKHTUserManager skarg_doUserLogin];
        return;
    }
    if (self.onItemTappedBlock) {
        self.onItemTappedBlock(sender.tag);
    }
}


@end
