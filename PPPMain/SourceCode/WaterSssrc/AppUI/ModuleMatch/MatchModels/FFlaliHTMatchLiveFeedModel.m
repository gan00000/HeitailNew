#import "FFlaliHTMatchLiveFeedModel.h"
@implementation FFlaliHTMatchLiveFeedModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"feed_id": @"id",
             @"desc": @"description"
             };
}
@end
