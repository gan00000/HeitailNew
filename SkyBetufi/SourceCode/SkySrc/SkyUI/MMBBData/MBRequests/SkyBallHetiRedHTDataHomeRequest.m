#import "SkyBallHetiRedHTDataHomeRequest.h"
@implementation SkyBallHetiRedHTDataHomeRequest
+ (void)waterSkyrequestWithType:(NSInteger)type successBlock:(void(^)(SkyBallHetiRedHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            SkyBallHetiRedHTDataHomeInfoModel *infoModel = [SkyBallHetiRedHTDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}
@end
