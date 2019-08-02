#import "SkyBallHetiRedHTRankZoneModel.h"
@implementation SkyBallHetiRedHTRankZoneModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"EasternAtlantic": [SkyBallHetiRedHTRankModel class],
             @"EasternCentral": [SkyBallHetiRedHTRankModel class],
             @"EasternSoutheast": [SkyBallHetiRedHTRankModel class],
             @"WesternNorthwest": [SkyBallHetiRedHTRankModel class],
             @"WesternPacific": [SkyBallHetiRedHTRankModel class],
             @"WesternSouthwest": [SkyBallHetiRedHTRankModel class]
             };
}
- (void)setEasternAtlantic:(NSArray<SkyBallHetiRedHTRankModel *> *)EasternAtlantic {
    _EasternAtlantic = [EasternAtlantic sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SkyBallHetiRedHTRankModel *model1 = obj1;
        SkyBallHetiRedHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setEasternCentral:(NSArray<SkyBallHetiRedHTRankModel *> *)EasternCentral {
    _EasternCentral = [EasternCentral sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SkyBallHetiRedHTRankModel *model1 = obj1;
        SkyBallHetiRedHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setEasternSoutheast:(NSArray<SkyBallHetiRedHTRankModel *> *)EasternSoutheast {
    _EasternSoutheast = [EasternSoutheast sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SkyBallHetiRedHTRankModel *model1 = obj1;
        SkyBallHetiRedHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternPacific:(NSArray<SkyBallHetiRedHTRankModel *> *)WesternPacific {
    _WesternPacific = [WesternPacific sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SkyBallHetiRedHTRankModel *model1 = obj1;
        SkyBallHetiRedHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternSouthwest:(NSArray<SkyBallHetiRedHTRankModel *> *)WesternSouthwest {
    _WesternSouthwest = [WesternSouthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SkyBallHetiRedHTRankModel *model1 = obj1;
        SkyBallHetiRedHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternNorthwest:(NSArray<SkyBallHetiRedHTRankModel *> *)WesternNorthwest {
    _WesternNorthwest = [WesternNorthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        SkyBallHetiRedHTRankModel *model1 = obj1;
        SkyBallHetiRedHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
@end
