#import <Foundation/Foundation.h>
#import "BlysaBJHTTPServiceEngine.h"
#import "NSNiceHTMatchSummaryModel.h"
#import "WSKggHTMatchCompareModel.h"
#import "NSNiceHTMacthLivePostModel.h"
#import "YeYeeHTLikeTeamModel.h"
#import "BByasHotShootPointModel.h"

@interface MMoogHTMatchSummaryRequest : NSObject
+ (void)taorequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(NSNiceHTMatchSummaryModel *summaryModel, WSKggHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLivePostWithGameId:(NSString *)game_id
successBlock:(void(^)(NSNiceHTMacthLivePostModel * livePost))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLikeMatchTeamWithGameId:(NSString *)game_id
                   type:(NSString *)type
successBlock:(void(^)(YeYeeHTLikeTeamModel * m))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestPlayerInfo:(NSString *)game_id
                  teamId:(NSString *)team_id
                playerId:(NSString *)player_id
               successBlock:(void(^)(NSArray<TuTuosHTMatchDetailsModel *> * model))successBlock
               errorBlock:(BJServiceErrorBlock)errorBlock;


+ (void)getShootPointWithGameId:(NSString *)game_id
            home_away:(NSString *)home_away //1-主队 2-客队
                playerId:(NSString *)player_id
                 quarter:(NSString *)quarter
               successBlock:(void(^)(NSArray<BByasHotShootPointModel *> * model))successBlock
           errorBlock:(BJServiceErrorBlock)errorBlock;
@end
