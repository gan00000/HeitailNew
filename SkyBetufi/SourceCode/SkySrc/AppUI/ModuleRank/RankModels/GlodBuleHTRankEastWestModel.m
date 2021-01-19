#import "GlodBuleHTRankEastWestModel.h"
@implementation GlodBuleHTRankEastWestModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Eastern": [GlodBuleHTRankModel class],
             @"Western": [GlodBuleHTRankModel class]
             };
}
- (void)setEastern:(NSArray<GlodBuleHTRankModel *> *)Eastern {
    _Eastern = [Eastern sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
- (void)setWestern:(NSArray<GlodBuleHTRankModel *> *)Western {
    _Western = [Western sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
