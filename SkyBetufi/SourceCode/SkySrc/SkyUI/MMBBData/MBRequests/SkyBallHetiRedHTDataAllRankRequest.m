#import "SkyBallHetiRedHTDataAllRankRequest.h"
@implementation SkyBallHetiRedHTDataAllRankRequest
+ (void)waterSkyrequestAllTeamRankDataWithType:(NSString *)type
                          successBlock:(void(^)(NSArray<SkyBallHetiRedHTDataTeamRankModel *> *allTeamRankList))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": type,
                             @"sort_by": @"desc"
                             };
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_TEAM_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *allTeamRankList = [NSArray yy_modelArrayWithClass:[SkyBallHetiRedHTDataTeamRankModel class] json:responseData[@"teams_rank"]];
            successBlock(allTeamRankList);
        }
    } errorBlock:errorBlock];
}
+ (void)requestAllPlayerRankDataWithType:(NSString *)type
                            successBlock:(void(^)(NSArray<SkyBallHetiRedHTDataPlayerRankModel *> *allPlayerRankList))successBlock
                              errorBlock:(BJServiceErrorBlock)errorBlock {
    NSDictionary *params = @{
                             @"type": type,
                             @"sort_by": @"desc"
                             };
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_PLAYER_RANK_ALL params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSArray *allTeamRankList = [NSArray yy_modelArrayWithClass:[SkyBallHetiRedHTDataPlayerRankModel class] json:responseData[@"players_rank"]];
            successBlock(allTeamRankList);
        }
    } errorBlock:errorBlock];
}
@end
