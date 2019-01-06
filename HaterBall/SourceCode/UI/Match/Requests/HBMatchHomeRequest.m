#import "HBMatchHomeRequest.h"
@implementation HBMatchHomeRequest
+ (void)requestWithStartDate:(NSString *)startDate
                     endDate:(NSString *)endDate
                successBlock:(void(^)(NSArray<HBMatchHomeGroupModel *> *matchList))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"date_from"] = startDate;
    params[@"date_to"] = endDate;
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:API_MATCH_HOME params:params successBlock:^(id responseData) {
        NSArray *allMatchList = [NSArray yy_modelArrayWithClass:[HBMatchHomeModel class] json:responseData[@"matches"]];
        NSMutableArray *groupedMatchList = [NSMutableArray array];
        NSMutableArray *matchList;
        NSString *groupName = @"";
        for (HBMatchHomeModel *matchModel in allMatchList) {
            if (![matchModel.gamedate isEqualToString:groupName]) {
                matchList = [NSMutableArray array];
                HBMatchHomeGroupModel *groupModel = [[HBMatchHomeGroupModel alloc] init];
                groupModel.groupName = matchModel.gamedate;
                groupModel.matchList = matchList;
                [groupedMatchList addObject:groupModel];
                groupName = groupModel.groupName;
            }
            [matchList addObject:matchModel];
        }
        if (successBlock) {
            successBlock(groupedMatchList);
        }
    } errorBlock:errorBlock];
}
+ (void)requestMatchProgressWithGameId:(NSString *)game_id
                          successBlock:(void(^)(NSString *game_id, NSString *quarter, NSString *time))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"game_id"] = game_id;
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:API_MATCH_PROGRESS params:params successBlock:^(id responseData) {
        if (successBlock) {
            NSDictionary *match_progress = responseData[@"match_progress"];
            successBlock(match_progress[@"game_id"], match_progress[@"quarter"], match_progress[@"time"]);
        }
    } errorBlock:errorBlock];
}
@end
