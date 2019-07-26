//
//  XRRFATKHTDataHomeHeaderCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/17.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTDataHomeHeaderCell.h"

@interface XRRFATKHTDataHomeHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

@implementation XRRFATKHTDataHomeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.arrowImageView.image = [self.arrowImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
