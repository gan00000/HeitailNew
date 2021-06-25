#import "YeYeeHTRankZoneRequest.h"
@implementation YeYeeHTRankZoneRequest
+ (void)taorequestWithSuccessBlock:(void(^)(FFlaliHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            FFlaliHTRankZoneModel *zoneModel = [FFlaliHTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}
@end
