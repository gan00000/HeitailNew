//
//  XRRFATKHTRankLeftCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/18.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRRFATKHTRankModel.h"

@interface XRRFATKHTRankLeftCell : UITableViewCell

- (void)refreshWithRankModel:(XRRFATKHTRankModel *)rankModel row:(NSInteger)row;

@end

