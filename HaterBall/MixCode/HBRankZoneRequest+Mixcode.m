#import "HBRankZoneRequest+Mixcode.h"
@implementation HBRankZoneRequest (Mixcode)
+ (void)requestWithSuccessBlock:(void(^)(HBRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
