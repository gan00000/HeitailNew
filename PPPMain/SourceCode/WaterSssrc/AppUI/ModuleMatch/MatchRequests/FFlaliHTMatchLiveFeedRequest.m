#import "FFlaliHTMatchLiveFeedRequest.h"
@implementation FFlaliHTMatchLiveFeedRequest
+ (void)taorequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<FFlaliHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_LIVE_FEED params:@{@"game_id":game_id} successBlock:^(id responseData) {
        NSMutableArray *feedList = [NSMutableArray array];
        NSArray *data = responseData[@"live_feed"];
        NSInteger toCount = 0;
        if ([data isKindOfClass:[NSArray class]] && data.count > 0) {
            if (data.count > 4) {
                toCount = data.count - 4;
            }
            for (NSArray *q in data) {
                NSArray *quarter = [NSArray yy_modelArrayWithClass:[FFlaliHTMatchLiveFeedModel class] json:q];
                [feedList addObjectsFromArray:quarter];
            }
        }
        
        FFlaliHTMatchLiveFeedModel *currentModel;
        for (FFlaliHTMatchLiveFeedModel *m in feedList) {
            m.toCount = toCount;
            if (currentModel) {
                
                if ([m.awayPts intValue] > [currentModel.awayPts intValue] || [m.homePts intValue] > [currentModel.homePts intValue]) {
                    m.tagSrore = 1;
                }else if ([m.awayPts intValue] < [currentModel.awayPts intValue] || [m.homePts intValue] < [currentModel.homePts intValue]){
                    currentModel.tagSrore = 1;
                }
            }
          
            currentModel = m;
        }
        if (successBlock) {
            successBlock(feedList);
        }
    } errorBlock:errorBlock];
}
@end