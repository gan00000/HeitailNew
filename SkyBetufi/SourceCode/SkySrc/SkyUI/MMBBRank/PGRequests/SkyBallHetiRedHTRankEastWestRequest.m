#import "SkyBallHetiRedHTRankEastWestRequest.h"
@implementation SkyBallHetiRedHTRankEastWestRequest
+ (void)waterSkyrequestWithSuccessBlock:(void(^)(SkyBallHetiRedHTRankEastWestModel *eastWestModel))successBlock
                     errorBlock:(BJServiceErrorBlock)errorBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_RANK_EAST_WEST params:nil successBlock:^(id responseData) {
        SkyBallHetiRedHTRankEastWestModel *eastWestModel = [SkyBallHetiRedHTRankEastWestModel yy_modelWithJSON:responseData];
        if (successBlock) {
            successBlock(eastWestModel);
        }
    } errorBlock:errorBlock];
}
@end
