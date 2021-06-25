#import "BByasHTDataHomeRequest.h"
@implementation BByasHTDataHomeRequest
+ (void)taorequestWithType:(NSInteger)type successBlock:(void(^)(KSasxHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            KSasxHTDataHomeInfoModel *infoModel = [KSasxHTDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}
@end
