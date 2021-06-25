#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "FFlaliHTRankZoneModel.h"
@interface YeYeeHTRankZoneRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(FFlaliHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
