#import "BByasHTDataHomeRequest.h"
@implementation BByasHTDataHomeRequest
+ (void)taorequestWithType:(NSInteger)type successBlock:(void(^)(TuTuosHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            TuTuosHTDataHomeInfoModel *infoModel = [TuTuosHTDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}
@end
