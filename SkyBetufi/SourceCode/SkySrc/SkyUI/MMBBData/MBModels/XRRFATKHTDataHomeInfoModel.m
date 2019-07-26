//
//  XRRFATKHTDataHomeInfoModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/12.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTDataHomeInfoModel.h"

@implementation XRRFATKHTDataHomeInfoModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [XRRFATKHTDataHomeModel class],
             @"reb": [XRRFATKHTDataHomeModel class],
             @"ast": [XRRFATKHTDataHomeModel class],
             @"stl": [XRRFATKHTDataHomeModel class],
             @"blk": [XRRFATKHTDataHomeModel class],
             @"turnover": [XRRFATKHTDataHomeModel class]
             };
}

@end
