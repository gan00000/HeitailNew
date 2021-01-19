#import "GlodBuleHTRankEastWestRequest.h"
@implementation GlodBuleHTRankEastWestRequest
+ (void)taorequestWithSuccessBlock:(void(^)(GlodBuleHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [GlodBuleBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_RANK_EAST_WEST params:nil successBlock:^(id responseData) {
        GlodBuleHTRankEastWestModel *eastWestModel = [GlodBuleHTRankEastWestModel yy_modelWithJSON:responseData];
        if (successBlock) {
            successBlock(eastWestModel);
        }
    } errorBlock:errorBlock];
}
@end
