#import "RRDogHTDataHomeRequest.h"
@implementation RRDogHTDataHomeRequest
+ (void)taorequestWithType:(NSInteger)type successBlock:(void(^)(CCCaseHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [PXFunBJHTTPServiceEngine tao_getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            CCCaseHTDataHomeInfoModel *infoModel = [CCCaseHTDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}
@end
