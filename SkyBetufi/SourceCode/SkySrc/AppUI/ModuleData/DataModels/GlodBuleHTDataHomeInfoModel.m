#import "GlodBuleHTDataHomeInfoModel.h"
@implementation GlodBuleHTDataHomeInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [GlodBuleHTDataHomeModel class],
             @"reb": [GlodBuleHTDataHomeModel class],
             @"ast": [GlodBuleHTDataHomeModel class],
             @"stl": [GlodBuleHTDataHomeModel class],
             @"blk": [GlodBuleHTDataHomeModel class],
             @"turnover": [GlodBuleHTDataHomeModel class]
             };
}
@end
