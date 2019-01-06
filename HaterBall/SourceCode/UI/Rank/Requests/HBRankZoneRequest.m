#import "HBRankZoneRequest.h"
@implementation HBRankZoneRequest
+ (void)requestWithSuccessBlock:(void(^)(HBRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            HBRankZoneModel *zoneModel = [HBRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}
@end
