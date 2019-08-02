#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTRankZoneModel.h"
@interface SkyBallHetiRedHTRankZoneRequest : NSObject
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(SkyBallHetiRedHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
