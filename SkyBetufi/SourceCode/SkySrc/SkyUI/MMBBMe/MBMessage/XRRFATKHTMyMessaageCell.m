//
//  XRRFATKHTMyMessaageCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/15.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTMyMessaageCell.h"
#import "XRRFATKBJDateFormatUtility.h"

@interface XRRFATKHTMyMessaageCell ()

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation XRRFATKHTMyMessaageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)skargrefreshWithMyMessageModel:(XRRFATKHTMyMessageModel *)model {
    self.descLabel.text = model.desc;
    self.contentLabel.text = model.reply_msg;
    self.titleLabel.text = model.post_title;
    self.timeLabel.text = [XRRFATKBJDateFormatUtility dateToShowFromDate:model.date];
}

@end
