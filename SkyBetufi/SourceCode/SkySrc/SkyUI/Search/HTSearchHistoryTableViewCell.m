//
//  HTSearchHistoryTableViewCell.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2020/9/7.
//  Copyright © 2020 Dean_F. All rights reserved.
//

#import "HTSearchHistoryTableViewCell.h"

@interface HTSearchHistoryTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *searchHistoryLabel;


@end

@implementation HTSearchHistoryTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setHistory:(NSString *)tx{
    self.searchHistoryLabel.text = tx;
}

- (IBAction)deleteBtnAction:(id)sender {
    if (self.mClickHander) {
        self.mClickHander(1);
    }
}

@end
