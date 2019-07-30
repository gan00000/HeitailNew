#import "XRRFATKHTRankEastWestRequest.h"
@implementation XRRFATKHTRankEastWestRequest
+ (void)skargrequestWithSuccessBlock:(void(^)(XRRFATKHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_RANK_EAST_WEST params:nil successBlock:^(id responseData) {
        XRRFATKHTRankEastWestModel *eastWestModel = [XRRFATKHTRankEastWestModel yy_modelWithJSON:responseData];
        if (successBlock) {
            successBlock(eastWestModel);
        }
    } errorBlock:errorBlock];
}
@end
