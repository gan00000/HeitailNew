#import "GlodBuleHTRankZoneRequest.h"
@implementation GlodBuleHTRankZoneRequest
+ (void)taorequestWithSuccessBlock:(void(^)(GlodBuleHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            GlodBuleHTRankZoneModel *zoneModel = [GlodBuleHTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}
@end
