//
//  YeYeeHTChatContentCell.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/14.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "BlysaHTChatSelfContentCell.h"
#import "UIColor+FFlaliHex.h"

@interface BlysaHTChatSelfContentCell()



@end

@implementation BlysaHTChatSelfContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"f3f3f4"];
//    self.chatContentLabel.adjustsFontSizeToFitWidth = YES;
    self.chatContentLabel.backgroundColor = [UIColor colorWithHexString:@"aae77e"];
    
    self.chatContentLabel.preferredMaxLayoutWidth = 300;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setChaMsg:(NSString *) msg
{
    self.chatContentLabel.text = msg;
}

@end
