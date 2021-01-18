#import "GlodBuleHTRankZoneRequest.h"
@implementation GlodBuleHTRankZoneRequest
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(GlodBuleHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [GlodBuleBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            GlodBuleHTRankZoneModel *zoneModel = [GlodBuleHTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}
@end
