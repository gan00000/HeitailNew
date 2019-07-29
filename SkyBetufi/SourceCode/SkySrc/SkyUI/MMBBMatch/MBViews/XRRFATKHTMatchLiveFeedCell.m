//
//  XRRFATKHTMatchLiveFeedCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTMatchLiveFeedCell.h"

@interface XRRFATKHTMatchLiveFeedCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptsCompareLabel;

@end

@implementation XRRFATKHTMatchLiveFeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)skargsetupWithMatchLiveFeedModel:(XRRFATKHTMatchLiveFeedModel *)feedModel {
    self.timeLabel.text = feedModel.time;
    self.teamLabel.text = feedModel.teamName;
    self.eventLabel.text = feedModel.desc;
    self.ptsCompareLabel.text = [NSString stringWithFormat:@"%@ - %@", feedModel.awayPts, feedModel.homePts];
}

@end
