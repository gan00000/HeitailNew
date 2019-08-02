#import "SkyBallHetiRedHTDataHomeInfoModel.h"
@implementation SkyBallHetiRedHTDataHomeInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [SkyBallHetiRedHTDataHomeModel class],
             @"reb": [SkyBallHetiRedHTDataHomeModel class],
             @"ast": [SkyBallHetiRedHTDataHomeModel class],
             @"stl": [SkyBallHetiRedHTDataHomeModel class],
             @"blk": [SkyBallHetiRedHTDataHomeModel class],
             @"turnover": [SkyBallHetiRedHTDataHomeModel class]
             };
}
@end
