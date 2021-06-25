#import "KSasxHTDataHomeInfoModel.h"
@implementation KSasxHTDataHomeInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [NSNiceHTDataHomeModel class],
             @"reb": [NSNiceHTDataHomeModel class],
             @"ast": [NSNiceHTDataHomeModel class],
             @"stl": [NSNiceHTDataHomeModel class],
             @"blk": [NSNiceHTDataHomeModel class],
             @"turnover": [NSNiceHTDataHomeModel class]
             };
}
@end
