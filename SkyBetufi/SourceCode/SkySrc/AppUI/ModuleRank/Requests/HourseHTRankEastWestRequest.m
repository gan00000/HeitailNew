#import "HourseHTRankEastWestRequest.h"
@implementation HourseHTRankEastWestRequest
+ (void)taorequestWithSuccessBlock:(void(^)(HourseHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_RANK_EAST_WEST params:nil successBlock:^(id responseData) {
        HourseHTRankEastWestModel *eastWestModel = [HourseHTRankEastWestModel yy_modelWithJSON:responseData];
        if (successBlock) {
            successBlock(eastWestModel);
        }
    } errorBlock:errorBlock];
}
@end
