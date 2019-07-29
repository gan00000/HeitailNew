//
//  XRRFATKHTNewsHomeBannerCell.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/9.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRRFATKHTNewsModel.h"

@interface XRRFATKHTNewsHomeBannerCell : UITableViewCell

@property (nonatomic, copy) void(^onBannerTappedBlock)(XRRFATKHTNewsModel *newsModel);

- (void)skargsetupWithNewsModels:(NSArray *)bannerList;

@end
