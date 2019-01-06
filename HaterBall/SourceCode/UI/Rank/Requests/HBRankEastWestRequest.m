#import "HBRankEastWestRequest.h"
@implementation HBRankEastWestRequest
+ (void)requestWithSuccessBlock:(void(^)(HBRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:API_RANK_EAST_WEST params:nil successBlock:^(id responseData) {
        HBRankEastWestModel *eastWestModel = [HBRankEastWestModel yy_modelWithJSON:responseData];
        if (successBlock) {
            successBlock(eastWestModel);
        }
    } errorBlock:errorBlock];
}
@end
