//
//  RRDogHTNewsImageTypeCell.m
//  XXXHeiTai
//
//  Created by ganyuanrong on 2021/4/2.
//  Copyright © 2021 Dean_F. All rights reserved.
//

#import "RRDogHTNewsImageTypeCell.h"

@implementation RRDogHTNewsImageTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.newsImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
