#import "XRRFATKHTRankZoneRequest.h"
@implementation XRRFATKHTRankZoneRequest
+ (void)skargrequestWithSuccessBlock:(void(^)(XRRFATKHTRankZoneModel *zoneModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_RANK_ZONE params:nil successBlock:^(id responseData) {
        if (successBlock) {
            XRRFATKHTRankZoneModel *zoneModel = [XRRFATKHTRankZoneModel yy_modelWithJSON:responseData];
            successBlock(zoneModel);
        }
    } errorBlock:errorBlock];
}
@end
