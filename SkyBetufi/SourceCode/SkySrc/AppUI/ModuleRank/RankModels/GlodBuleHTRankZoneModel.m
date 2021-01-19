#import "GlodBuleHTRankZoneModel.h"
@implementation GlodBuleHTRankZoneModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"EasternAtlantic": [GlodBuleHTRankModel class],
             @"EasternCentral": [GlodBuleHTRankModel class],
             @"EasternSoutheast": [GlodBuleHTRankModel class],
             @"WesternNorthwest": [GlodBuleHTRankModel class],
             @"WesternPacific": [GlodBuleHTRankModel class],
             @"WesternSouthwest": [GlodBuleHTRankModel class]
             };
}
- (void)setEasternAtlantic:(NSArray<GlodBuleHTRankModel *> *)EasternAtlantic {
    _EasternAtlantic = [EasternAtlantic sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        GlodBuleHTRankModel *model1 = obj1;
        GlodBuleHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setEasternCentral:(NSArray<GlodBuleHTRankModel *> *)EasternCentral {
    _EasternCentral = [EasternCentral sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        GlodBuleHTRankModel *model1 = obj1;
        GlodBuleHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setEasternSoutheast:(NSArray<GlodBuleHTRankModel *> *)EasternSoutheast {
    _EasternSoutheast = [EasternSoutheast sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        GlodBuleHTRankModel *model1 = obj1;
        GlodBuleHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternPacific:(NSArray<GlodBuleHTRankModel *> *)WesternPacific {
    _WesternPacific = [WesternPacific sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        GlodBuleHTRankModel *model1 = obj1;
        GlodBuleHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternSouthwest:(NSArray<GlodBuleHTRankModel *> *)WesternSouthwest {
    _WesternSouthwest = [WesternSouthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        GlodBuleHTRankModel *model1 = obj1;
        GlodBuleHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWesternNorthwest:(NSArray<GlodBuleHTRankModel *> *)WesternNorthwest {
    _WesternNorthwest = [WesternNorthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        GlodBuleHTRankModel *model1 = obj1;
        GlodBuleHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
@end
