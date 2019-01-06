#import "HBDataHomeInfoModel.h"
@implementation HBDataHomeInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [HBDataHomeModel class],
             @"reb": [HBDataHomeModel class],
             @"ast": [HBDataHomeModel class],
             @"stl": [HBDataHomeModel class],
             @"blk": [HBDataHomeModel class],
             @"turnover": [HBDataHomeModel class]
             };
}
@end
