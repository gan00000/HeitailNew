#import "UUaksHTMatchLiveFeedModel.h"
@implementation UUaksHTMatchLiveFeedModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"feed_id": @"id",
             @"desc": @"description"
             };
}
@end
