#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBRankZoneModel.h"
#import "HBRankZoneRequest.h"

@interface HBRankZoneRequest (Mixcode)
+ (void)requestWithSuccessBlock:(void(^)(HBRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock mixcode:(NSString *)mixcode;

@end
