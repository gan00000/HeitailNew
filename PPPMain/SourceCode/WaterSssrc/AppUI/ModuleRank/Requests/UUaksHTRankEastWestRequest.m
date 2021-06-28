#import "UUaksHTRankEastWestRequest.h"
@implementation UUaksHTRankEastWestRequest
+ (void)taorequestWithSuccessBlock:(void(^)(BByasHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_RANK_EAST_WEST params:nil successBlock:^(id responseData) {
        BByasHTRankEastWestModel *eastWestModel = [BByasHTRankEastWestModel yy_modelWithJSON:responseData];
        if (successBlock) {
            successBlock(eastWestModel);
        }
    } errorBlock:errorBlock];
}
@end
