//
//  XRRFATKHTDataPlayerLeftCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTDataPlayerLeftCell.h"

@interface XRRFATKHTDataPlayerLeftCell ()

@property (weak, nonatomic) IBOutlet UILabel *oderLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation XRRFATKHTDataPlayerLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)skargrefreshWithPlayerModel:(XRRFATKHTDataPlayerRankModel *)playerModel row:(NSInteger)row {
    self.oderLabel.text = [NSString stringWithFormat:@"%ld", row + 1];
    self.nameLabel.text = playerModel.name;
    
    self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"FFFFFF"];
    if (row % 2 == 1) {
        self.contentView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"f4f7f0"];
    }
}

@end
