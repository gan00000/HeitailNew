#import <Foundation/Foundation.h>
#import "HBBJHTTPServiceEngine.h"
#import "HBRankZoneModel.h"
@interface HBRankZoneRequest : NSObject
+ (void)requestWithSuccessBlock:(void(^)(HBRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
