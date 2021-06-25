#import <Foundation/Foundation.h>
#import "NSNiceBJHTTPServiceEngine.h"
#import "KSasxHTMatchSummaryModel.h"
#import "BByasHTMatchCompareModel.h"
#import "KSasxHTMacthLivePostModel.h"
#import "BByasHTLikeTeamModel.h"
#import "TuTuosHotShootPointModel.h"

@interface MMoogHTMatchSummaryRequest : NSObject
+ (void)taorequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(KSasxHTMatchSummaryModel *summaryModel, BByasHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLivePostWithGameId:(NSString *)game_id
successBlock:(void(^)(KSasxHTMacthLivePostModel * livePost))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLikeMatchTeamWithGameId:(NSString *)game_id
                   type:(NSString *)type
successBlock:(void(^)(BByasHTLikeTeamModel * m))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestPlayerInfo:(NSString *)game_id
                  teamId:(NSString *)team_id
                playerId:(NSString *)player_id
               successBlock:(void(^)(NSArray<UUaksHTMatchDetailsModel *> * model))successBlock
               errorBlock:(BJServiceErrorBlock)errorBlock;


+ (void)getShootPointWithGameId:(NSString *)game_id
            home_away:(NSString *)home_away //1-主队 2-客队
                playerId:(NSString *)player_id
                 quarter:(NSString *)quarter
               successBlock:(void(^)(NSArray<TuTuosHotShootPointModel *> * model))successBlock
           errorBlock:(BJServiceErrorBlock)errorBlock;
@end
