//
//  XRRFATKHTDataTeamLeftCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRRFATKHTDataTeamRankModel.h"

@interface XRRFATKHTDataTeamLeftCell : UITableViewCell

- (void)skargrefreshWithTeamModel:(XRRFATKHTDataTeamRankModel *)teamModel row:(NSInteger)row;

@end
