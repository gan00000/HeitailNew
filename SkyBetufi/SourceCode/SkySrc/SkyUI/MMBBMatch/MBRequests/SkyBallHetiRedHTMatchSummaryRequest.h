#import <Foundation/Foundation.h>
#import "SkyBallHetiRedBJHTTPServiceEngine.h"
#import "SkyBallHetiRedHTMatchSummaryModel.h"
#import "SkyBallHetiRedHTMatchCompareModel.h"
#import "HTMacthLivePostModel.h"

@interface SkyBallHetiRedHTMatchSummaryRequest : NSObject
+ (void)waterSkyrequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(SkyBallHetiRedHTMatchSummaryModel *summaryModel, SkyBallHetiRedHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLivePostWithGameId:(NSString *)game_id
successBlock:(void(^)(HTMacthLivePostModel * livePost))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;
@end
