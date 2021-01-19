#import "GlodBuleHTMatchLiveFeedModel.h"
@implementation GlodBuleHTMatchLiveFeedModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"feed_id": @"id",
             @"desc": @"description"
             };
}
@end
