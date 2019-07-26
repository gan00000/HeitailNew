//
//  XRRFATKHTMatchDataRightCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/17.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRRFATKHTMatchDetailsModel.h"

@interface XRRFATKHTMatchDataRightCell : UITableViewCell

- (void)refreshWithModel:(XRRFATKHTMatchDetailsModel *)model row:(NSInteger)row;

@end
