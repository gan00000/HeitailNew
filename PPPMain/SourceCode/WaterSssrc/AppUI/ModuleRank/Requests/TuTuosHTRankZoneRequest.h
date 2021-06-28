#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "MMoogHTRankZoneModel.h"
@interface TuTuosHTRankZoneRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(MMoogHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
