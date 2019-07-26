//
//  XRRFATKHTMatchLiveFeedModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/23.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTMatchLiveFeedModel.h"

@implementation XRRFATKHTMatchLiveFeedModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"feed_id": @"id",
             @"desc": @"description"
             };
}

@end
