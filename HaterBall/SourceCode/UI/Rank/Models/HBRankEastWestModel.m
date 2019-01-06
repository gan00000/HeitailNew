#import "HBRankEastWestModel.h"
@implementation HBRankEastWestModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Eastern": [HBRankModel class],
             @"Western": [HBRankModel class]
             };
}
- (void)setEastern:(NSArray<HBRankModel *> *)Eastern {
    _Eastern = [Eastern sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HBRankModel *model1 = obj1;
        HBRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWestern:(NSArray<HBRankModel *> *)Western {
    _Western = [Western sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        HBRankModel *model1 = obj1;
        HBRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
@end
