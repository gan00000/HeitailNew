#import "CCCaseHTDataHomeInfoModel.h"
@implementation CCCaseHTDataHomeInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [PXFunHTDataHomeModel class],
             @"reb": [PXFunHTDataHomeModel class],
             @"ast": [PXFunHTDataHomeModel class],
             @"stl": [PXFunHTDataHomeModel class],
             @"blk": [PXFunHTDataHomeModel class],
             @"turnover": [PXFunHTDataHomeModel class]
             };
}
@end
