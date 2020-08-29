#import "SkyBallHetiRedHTMatchLiveFeedRequest.h"
@implementation SkyBallHetiRedHTMatchLiveFeedRequest
+ (void)waterSkyrequestLiveFeedWithGameId:(NSString *)game_id
                     successBlock:(void(^)(NSArray<SkyBallHetiRedHTMatchLiveFeedModel *> *feedList))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestWithFunctionPath:API_MATCH_LIVE_FEED params:@{@"game_id":game_id} successBlock:^(id responseData) {
        NSMutableArray *feedList = [NSMutableArray array];
        NSArray *data = responseData[@"live_feed"];
        if ([data isKindOfClass:[NSArray class]] && data.count > 0) {
            for (NSArray *q in data) {
                NSArray *quarter = [NSArray yy_modelArrayWithClass:[SkyBallHetiRedHTMatchLiveFeedModel class] json:q];
                [feedList addObjectsFromArray:quarter];
            }
        }
        
        SkyBallHetiRedHTMatchLiveFeedModel *currentModel;
        for (SkyBallHetiRedHTMatchLiveFeedModel *m in feedList) {
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
