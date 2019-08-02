#import "SkyBallHetiRedHTRankZoneRequest.h"
@implementation SkyBallHetiRedHTRankZoneRequest
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(SkyBallHetiRedHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            SkyBallHetiRedHTRankZoneModel *zoneModel = [SkyBallHetiRedHTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}
@end
