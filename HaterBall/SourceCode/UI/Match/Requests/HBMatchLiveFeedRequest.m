#import "HBMatchLiveFeedRequest.h"
@implementation HBMatchLiveFeedRequest
+ (void)requestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<HBMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock {
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:API_MATCH_LIVE_FEED params:@{@"game_id":game_id} successBlock:^(id responseData) {
        NSMutableArray *feedList = [NSMutableArray array];
        NSArray *data = responseData[@"live_feed"];
        if ([data isKindOfClass:[NSArray class]] && data.count > 0) {
            for (NSArray *q in data) {
                NSArray *quarter = [NSArray yy_modelArrayWithClass:[HBMatchLiveFeedModel class] json:q];
                [feedList addObjectsFromArray:quarter];
            }
        }        
        if (successBlock) {
            successBlock(feedList);
        }
    } errorBlock:errorBlock];
}
@end
