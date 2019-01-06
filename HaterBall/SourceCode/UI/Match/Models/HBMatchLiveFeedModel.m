#import "HBMatchLiveFeedModel.h"
@implementation HBMatchLiveFeedModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"feed_id": @"id",
             @"desc": @"description"
             };
}
@end
