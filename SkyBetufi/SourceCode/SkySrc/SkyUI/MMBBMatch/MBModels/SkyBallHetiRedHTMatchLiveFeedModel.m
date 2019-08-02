#import "SkyBallHetiRedHTMatchLiveFeedModel.h"
@implementation SkyBallHetiRedHTMatchLiveFeedModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"feed_id": @"id",
             @"desc": @"description"
             };
}
@end
