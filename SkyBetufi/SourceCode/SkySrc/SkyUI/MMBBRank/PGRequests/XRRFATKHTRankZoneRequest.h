#import <Foundation/Foundation.h>
#import "XRRFATKBJHTTPServiceEngine.h"
#import "XRRFATKHTRankZoneModel.h"
@interface XRRFATKHTRankZoneRequest : NSObject
+ (void)skargrequestWithSuccessBlock:(void(^)(XRRFATKHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock;
@end
