#import "XRRFATKHTMatchLiveFeedRequest.h"
@implementation XRRFATKHTMatchLiveFeedRequest
+ (void)skargrequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<XRRFATKHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine skarg_getRequestWithFunctionPath:API_MATCH_LIVE_FEED params:@{@"game_id":game_id} successBlock:^(id responseData) {
        NSMutableArray *feedList = [NSMutableArray array];
        NSArray *data = responseData[@"live_feed"];
        if ([data isKindOfClass:[NSArray class]] && data.count > 0) {
            for (NSArray *q in data) {
                NSArray *quarter = [NSArray yy_modelArrayWithClass:[XRRFATKHTMatchLiveFeedModel class] json:q];
                [feedList addObjectsFromArray:quarter];
            }
        }        
        if (successBlock) {
            successBlock(feedList);
        }
    } errorBlock:errorBlock];
}
@end
