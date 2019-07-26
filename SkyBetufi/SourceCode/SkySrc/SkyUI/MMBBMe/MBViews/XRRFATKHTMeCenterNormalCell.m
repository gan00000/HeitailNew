//
//  XRRFATKHTMeCenterNormalCell.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/5.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "XRRFATKHTMeCenterNormalCell.h"

@interface XRRFATKHTMeCenterNormalCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet JXView *messageCountContent;
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;

@end

@implementation XRRFATKHTMeCenterNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setMessageCount:(NSInteger)messageCount {
    self.messageCountContent.hidden = YES;
    if (messageCount) {
        self.messageCountContent.hidden = NO;
        self.messageCountLabel.text = [NSString stringWithFormat:@"%ld", messageCount];
    }
}

@end
