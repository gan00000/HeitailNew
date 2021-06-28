#import "TuTuosHTDataHomeInfoModel.h"
@implementation TuTuosHTDataHomeInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [BByasHTDataHomeModel class],
             @"reb": [BByasHTDataHomeModel class],
             @"ast": [BByasHTDataHomeModel class],
             @"stl": [BByasHTDataHomeModel class],
             @"blk": [BByasHTDataHomeModel class],
             @"turnover": [BByasHTDataHomeModel class]
             };
}
@end
