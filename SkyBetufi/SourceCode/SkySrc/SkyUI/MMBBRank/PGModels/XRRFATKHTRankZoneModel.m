#import "XRRFATKHTRankZoneModel.h"
@implementation XRRFATKHTRankZoneModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"EasternAtlantic": [XRRFATKHTRankModel class],
             @"EasternCentral": [XRRFATKHTRankModel class],
             @"EasternSoutheast": [XRRFATKHTRankModel class],
             @"WesternNorthwest": [XRRFATKHTRankModel class],
             @"WesternPacific": [XRRFATKHTRankModel class],
             @"WesternSouthwest": [XRRFATKHTRankModel class]
             };
}
- (void)setEasternAtlantic:(NSArray<XRRFATKHTRankModel *> *)EasternAtlantic {
    _EasternAtlantic = [EasternAtlantic sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
- (void)setEasternCentral:(NSArray<XRRFATKHTRankModel *> *)EasternCentral {
    _EasternCentral = [EasternCentral sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
- (void)setEasternSoutheast:(NSArray<XRRFATKHTRankModel *> *)EasternSoutheast {
    _EasternSoutheast = [EasternSoutheast sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
- (void)setWesternPacific:(NSArray<XRRFATKHTRankModel *> *)WesternPacific {
    _WesternPacific = [WesternPacific sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
- (void)setWesternSouthwest:(NSArray<XRRFATKHTRankModel *> *)WesternSouthwest {
    _WesternSouthwest = [WesternSouthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
- (void)setWesternNorthwest:(NSArray<XRRFATKHTRankModel *> *)WesternNorthwest {
    _WesternNorthwest = [WesternNorthwest sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
