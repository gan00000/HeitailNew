//
//  XRRFATKHTRankEastWestModel.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/14.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTRankEastWestModel.h"

@implementation XRRFATKHTRankEastWestModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Eastern": [XRRFATKHTRankModel class],
             @"Western": [XRRFATKHTRankModel class]
             };
}

- (void)setEastern:(NSArray<XRRFATKHTRankModel *> *)Eastern {
    _Eastern = [Eastern sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        XRRFATKHTRankModel *model1 = obj1;
        XRRFATKHTRankModel *model2 = obj2;
        
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

- (void)setWestern:(NSArray<XRRFATKHTRankModel *> *)Western {
    _Western = [Western sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        XRRFATKHTRankModel *model1 = obj1;
        XRRFATKHTRankModel *model2 = obj2;
        
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}

@end
