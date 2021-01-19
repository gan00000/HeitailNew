#import <Foundation/Foundation.h>
#import "GlodBuleBJHTTPServiceEngine.h"
#import "GlodBuleHTMatchSummaryModel.h"
#import "GlodBuleHTMatchCompareModel.h"
#import "GlodBuleHTMacthLivePostModel.h"
#import "GlodBuleHTLikeTeamModel.h"

@interface GlodBuleHTMatchSummaryRequest : NSObject
+ (void)taorequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(GlodBuleHTMatchSummaryModel *summaryModel, GlodBuleHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLivePostWithGameId:(NSString *)game_id
successBlock:(void(^)(GlodBuleHTMacthLivePostModel * livePost))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLikeMatchTeamWithGameId:(NSString *)game_id
                   type:(NSString *)type
successBlock:(void(^)(GlodBuleHTLikeTeamModel * m))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestPlayerInfo:(NSString *)game_id
                  teamId:(NSString *)team_id
                playerId:(NSString *)player_id
               successBlock:(void(^)(NSArray<GlodBuleHTMatchDetailsModel *> * model))successBlock
               errorBlock:(BJServiceErrorBlock)errorBlock;
@end
