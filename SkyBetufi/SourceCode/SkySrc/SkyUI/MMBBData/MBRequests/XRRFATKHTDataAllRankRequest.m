#import "XRRFATKHTDataAllRankRequest.h"
@implementation XRRFATKHTDataAllRankRequest
+ (void)skargrequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<XRRFATKHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": type,
                             @"sort_by": @"desc"
                             };
    [XRRFATKBJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_TEAM_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *allTeamRankList = [NSArray yy_modelArrayWithClass:[XRRFATKHTDataTeamRankModel class] json:responseData[@"teams_rank"]];
            successBlock(allTeamRankList);
        }
    } errorBlock:errorBlock];
}
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<XRRFATKHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": type,
                             @"sort_by": @"desc"
                             };
    [XRRFATKBJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_PLAYER_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *allTeamRankList = [NSArray yy_modelArrayWithClass:[XRRFATKHTDataPlayerRankModel class] json:responseData[@"players_rank"]];
            successBlock(allTeamRankList);
        }
    } errorBlock:errorBlock];
}
@end
