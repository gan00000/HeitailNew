//
//  XRRFATKHTDataCellPlayerView.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/13.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRRFATKHTDataHomeModel.h"

@interface XRRFATKHTDataCellPlayerView : UIView

+ (instancetype)dataCellViewWithFrame:(CGRect)frame addToView:(UIView *)view;
- (void)setupWithDataModel:(XRRFATKHTDataHomeModel *)dataModel;

@end
