//
//  HTRankEastWestModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "HTRankEastWestModel.h"

@implementation HTRankEastWestModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Eastern": [HTRankModel class],
             @"Western": [HTRankModel class]
             };
}

@end
