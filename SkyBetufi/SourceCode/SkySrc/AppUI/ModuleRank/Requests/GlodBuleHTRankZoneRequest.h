#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTRankZoneModel.h"
@interface GlodBuleHTRankZoneRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(GlodBuleHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
