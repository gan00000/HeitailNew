#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "NDeskHTRankZoneModel.h"
@interface RRDogHTRankZoneRequest : NSObject
+ (void)taorequestWithSuccessBlock:(void(^)(NDeskHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
