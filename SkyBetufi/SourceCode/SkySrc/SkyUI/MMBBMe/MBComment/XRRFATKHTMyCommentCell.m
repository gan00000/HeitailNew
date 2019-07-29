//
//  XRRFATKHTMyCommentCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/15.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTMyCommentCell.h"
#import "XRRFATKBJDateFormatUtility.h"

@interface XRRFATKHTMyCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation XRRFATKHTMyCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)skargsetupWithNewsModel:(XRRFATKHTNewsModel *)newsModel {
    self.avatarImageView.image = newsModel.userInfo.avatar;
    self.userNameLabel.text = [XRRFATKHTUserManager skarg_userInfo].display_name;
    self.timeLabel.text = [XRRFATKBJDateFormatUtility dateToShowFromDate:newsModel.comt_date_obj];
    self.contentLabel.text = newsModel.comment_content;
    self.titleLabel.text = newsModel.title;
}

@end
