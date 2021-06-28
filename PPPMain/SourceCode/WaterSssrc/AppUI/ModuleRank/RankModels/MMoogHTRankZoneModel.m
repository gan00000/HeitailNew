#import "MMoogHTRankZoneModel.h"
@implementation MMoogHTRankZoneModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"EasternAtlantic": [CfipyHTRankModel class],
             @"EasternCentral": [CfipyHTRankModel class],
             @"EasternSoutheast": [CfipyHTRankModel class],
             @"WesternNorthwest": [CfipyHTRankModel class],
             @"WesternPacific": [CfipyHTRankModel class],
             @"WesternSouthwest": [CfipyHTRankModel class]
             };
}
- (void)setEasternAtlantic:(NSArray<CfipyHTRankModel *> *)EasternAtlantic {
    _EasternAtlantic = [EasternAtlantic sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CfipyHTRankModel *model1 = obj1;
        CfipyHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setEasternCentral:(NSArray<CfipyHTRankModel *> *)EasternCentral {
    _EasternCentral = [EasternCentral sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CfipyHTRankModel *model1 = obj1;
        CfipyHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setEasternSoutheast:(NSArray<CfipyHTRankModel *> *)EasternSoutheast {
    _EasternSoutheast = [EasternSoutheast sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CfipyHTRankModel *model1 = obj1;
        CfipyHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternPacific:(NSArray<CfipyHTRankModel *> *)WesternPacific {
    _WesternPacific = [WesternPacific sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CfipyHTRankModel *model1 = obj1;
        CfipyHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternSouthwest:(NSArray<CfipyHTRankModel *> *)WesternSouthwest {
    _WesternSouthwest = [WesternSouthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CfipyHTRankModel *model1 = obj1;
        CfipyHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternNorthwest:(NSArray<CfipyHTRankModel *> *)WesternNorthwest {
    _WesternNorthwest = [WesternNorthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CfipyHTRankModel *model1 = obj1;
        CfipyHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
@end
