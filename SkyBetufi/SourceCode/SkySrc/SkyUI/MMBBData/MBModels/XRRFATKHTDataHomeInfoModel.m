#import "XRRFATKHTDataHomeInfoModel.h"
@implementation XRRFATKHTDataHomeInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"pts": [XRRFATKHTDataHomeModel class],
             @"reb": [XRRFATKHTDataHomeModel class],
             @"ast": [XRRFATKHTDataHomeModel class],
             @"stl": [XRRFATKHTDataHomeModel class],
             @"blk": [XRRFATKHTDataHomeModel class],
             @"turnover": [XRRFATKHTDataHomeModel class]
             };
}
@end
