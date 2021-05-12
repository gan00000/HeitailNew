#import "RRDogHTRankZoneRequest.h"
@implementation RRDogHTRankZoneRequest
+ (void)taorequestWithSuccessBlock:(void(^)(NDeskHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NDeskHTRankZoneModel *zoneModel = [NDeskHTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}
@end
