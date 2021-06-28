#import "TuTuosHTRankZoneRequest.h"
@implementation TuTuosHTRankZoneRequest
+ (void)taorequestWithSuccessBlock:(void(^)(MMoogHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            MMoogHTRankZoneModel *zoneModel = [MMoogHTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}
@end
