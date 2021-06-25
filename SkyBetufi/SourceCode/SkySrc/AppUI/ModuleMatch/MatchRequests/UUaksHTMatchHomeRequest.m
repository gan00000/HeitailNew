#import "UUaksHTMatchHomeRequest.h"
@implementation UUaksHTMatchHomeRequest
+ (void)taorequestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                 competition_id:(NSString *)competition_id
                successBlock:(void(^)(NSArray<YeYeeHTMatchHomeGroupModel *> *matchList, NSArray<TuTuosHTMatchHomeModel *> *matchA))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"date_from"] = startDate;
    params[@"date_to"] = endDate;
    if (competition_id) {
        params[@"competition_id"] = competition_id;
    }
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_HOME params:params successBlock:^(id responseData) {
        NSArray *allMatchList = [NSArray yy_modelArrayWithClass:[TuTuosHTMatchHomeModel class] json:responseData[@"matches"]];
        NSMutableArray *groupedMatchList = [NSMutableArray array];
        NSMutableArray *matchList;
        NSString *groupName = @"";
        for (TuTuosHTMatchHomeModel *matchModel in allMatchList) {
            if (![matchModel.gamedate isEqualToString:groupName]) {
                matchList = [NSMutableArray array];
                YeYeeHTMatchHomeGroupModel *groupModel = [[YeYeeHTMatchHomeGroupModel alloc] init];
                groupModel.groupName = matchModel.gamedate;
                groupModel.matchList = matchList;
                [groupedMatchList addObject:groupModel];
                groupName = groupModel.groupName;
            }
            [matchList addObject:matchModel];
        }
        if (successBlock) {
            successBlock(groupedMatchList, allMatchList);
        }
    } errorBlock:errorBlock];
}
+ (void)taorequestMatchProgressWithGameId:(NSString *)game_id
                          successBlock:(void(^)(NSString *game_id, NSString *quarter, NSString *time))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"game_id"] = game_id;
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_PROGRESS params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSDictionary *match_progress = responseData[@"match_progress"];
            successBlock(match_progress[@"game_id"], match_progress[@"quarter"], match_progress[@"time"]);
        }
    } errorBlock:errorBlock];
}

+ (void)get_league_list_successBlock:(void(^)(NSDictionary *leagueList))successBlock
             errorBlock:(BJServiceErrorBlock)errorBlock
{
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_GET_LEAGUE_LIST params:nil successBlock:^(id responseData) {
        if (successBlock) {
            NSDictionary *match_progress = responseData[@"result"];
            successBlock(match_progress);
        }
    } errorBlock:errorBlock];
}
@end
