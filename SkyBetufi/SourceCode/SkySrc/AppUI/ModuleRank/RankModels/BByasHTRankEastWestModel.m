#import "BByasHTRankEastWestModel.h"
@implementation BByasHTRankEastWestModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"Eastern": [FFlaliHTRankModel class],
             @"Western": [FFlaliHTRankModel class]
             };
}
- (void)setEastern:(NSArray<FFlaliHTRankModel *> *)Eastern {
    _Eastern = [Eastern sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        FFlaliHTRankModel *model1 = obj1;
        FFlaliHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
- (void)setWestern:(NSArray<FFlaliHTRankModel *> *)Western {
    _Western = [Western sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        FFlaliHTRankModel *model1 = obj1;
        FFlaliHTRankModel *model2 = obj2;
        if (model1.winRate.doubleValue > model2.winRate.doubleValue) {
            return NSOrderedAscending;
        } else if (model1.winRate.doubleValue == model2.winRate.doubleValue) {
            return NSOrderedSame;
        }
        return NSOrderedDescending;
    }];
}
@end
