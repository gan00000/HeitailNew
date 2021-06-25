#import "MMoogHTDataAllRankRequest.h"
@implementation MMoogHTDataAllRankRequest
+ (void)taorequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<TuTuosHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": type,
                             @"sort_by": @"desc"
                             };
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_TEAM_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *allTeamRankList = [NSArray yy_modelArrayWithClass:[TuTuosHTDataTeamRankModel class] json:responseData[@"teams_rank"]];
            successBlock(allTeamRankList);
        }
    } errorBlock:errorBlock];
}
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<TuTuosHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": type,
                             @"sort_by": @"desc"
                             };
    [BlysaBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_PLAYER_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *allTeamRankList = [NSArray yy_modelArrayWithClass:[TuTuosHTDataPlayerRankModel class] json:responseData[@"players_rank"]];
            successBlock(allTeamRankList);
        }
    } errorBlock:errorBlock];
}
@end
