#import "BByasHTRankEastWestModel.h"
@implementation BByasHTRankEastWestModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Eastern": [CfipyHTRankModel class],
             @"Western": [CfipyHTRankModel class]
             };
}
- (void)setEastern:(NSArray<CfipyHTRankModel *> *)Eastern {
    _Eastern = [Eastern sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
- (void)setWestern:(NSArray<CfipyHTRankModel *> *)Western {
    _Western = [Western sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
