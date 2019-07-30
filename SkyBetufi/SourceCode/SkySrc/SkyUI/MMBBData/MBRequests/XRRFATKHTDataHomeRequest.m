#import "XRRFATKHTDataHomeRequest.h"
@implementation XRRFATKHTDataHomeRequest
+ (void)skargrequestWithType:(NSInteger)type successBlock:(void(^)(XRRFATKHTDataHomeInfoModel *infoModel))successBlock errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine skarg_getRequestWithFunctionPath:type==1?API_PLAYER_RANK:API_TEAM_RANK params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSString *key = type==1?@"players":@"teams";
            XRRFATKHTDataHomeInfoModel *infoModel = [XRRFATKHTDataHomeInfoModel yy_modelWithJSON:responseData[key]];
            successBlock(infoModel);
        }
    } errorBlock:errorBlock];
}
@end
