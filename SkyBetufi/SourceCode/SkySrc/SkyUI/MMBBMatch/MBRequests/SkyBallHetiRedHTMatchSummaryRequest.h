#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTMatchSummaryModel.h"
#import "SkyBallHetiRedHTMatchCompareModel.h"
#import "HTMacthLivePostModel.h"
#import "HTLikeTeamModel.h"

@interface SkyBallHetiRedHTMatchSummaryRequest : NSObject
+ (void)waterSkyrequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(SkyBallHetiRedHTMatchSummaryModel *summaryModel, SkyBallHetiRedHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLivePostWithGameId:(NSString *)game_id
successBlock:(void(^)(HTMacthLivePostModel * livePost))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLikeMatchTeamWithGameId:(NSString *)game_id
                   type:(NSString *)type
successBlock:(void(^)(HTLikeTeamModel * m))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;
@end
