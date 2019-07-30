#import "XRRFATKHTMatchLiveFeedModel.h"
@implementation XRRFATKHTMatchLiveFeedModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"feed_id": @"id",
             @"desc": @"description"
             };
}
@end
