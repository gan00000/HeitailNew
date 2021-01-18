#import "GlodBuleHTDataHomeRequest.h"
@implementation GlodBuleHTDataHomeRequest
+ (void)waterSkyrequestWithType:(NSInteger)type successBlock:(void(^)(GlodBuleHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [GlodBuleBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            GlodBuleHTDataHomeInfoModel *infoModel = [GlodBuleHTDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}
@end
