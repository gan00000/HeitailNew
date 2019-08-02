#import "SkyBallHetiRedHTRankEastWestModel.h"
@implementation SkyBallHetiRedHTRankEastWestModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Eastern": [SkyBallHetiRedHTRankModel class],
             @"Western": [SkyBallHetiRedHTRankModel class]
             };
}
- (void)setEastern:(NSArray<SkyBallHetiRedHTRankModel *> *)Eastern {
    _Eastern = [Eastern sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
- (void)setWestern:(NSArray<SkyBallHetiRedHTRankModel *> *)Western {
    _Western = [Western sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
