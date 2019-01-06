#import "HBDataHomeRequest.h"
@implementation HBDataHomeRequest
+ (void)requestWithType:(NSInteger)type successBlock:(void(^)(HBDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            HBDataHomeInfoModel *infoModel = [HBDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}
@end
