#import <Foundation/Foundation.h>
#import "PXFunBJHTTPServiceEngine.h"
#import "NDeskHTMatchSummaryModel.h"
#import "PXFunHTMatchCompareModel.h"
#import "HourseHTMacthLivePostModel.h"
#import "NDeskHTLikeTeamModel.h"
#import "HourseHotShootPointModel.h"

@interface PXFunHTMatchSummaryRequest : NSObject
+ (void)taorequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(NDeskHTMatchSummaryModel *summaryModel, PXFunHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLivePostWithGameId:(NSString *)game_id
successBlock:(void(^)(HourseHTMacthLivePostModel * livePost))successBlock
                       errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestLikeMatchTeamWithGameId:(NSString *)game_id
                   type:(NSString *)type
successBlock:(void(^)(NDeskHTLikeTeamModel * m))successBlock
                            errorBlock:(BJServiceErrorBlock)errorBlock;

+ (void)requestPlayerInfo:(NSString *)game_id
                  teamId:(NSString *)team_id
                playerId:(NSString *)player_id
               successBlock:(void(^)(NSArray<SundayHTMatchDetailsModel *> * model))successBlock
               errorBlock:(BJServiceErrorBlock)errorBlock;


+ (void)getShootPointWithGameId:(NSString *)game_id
            home_away:(NSString *)home_away //1-主队 2-客队
                playerId:(NSString *)player_id
                 quarter:(NSString *)quarter
               successBlock:(void(^)(NSArray<HourseHotShootPointModel *> * model))successBlock
           errorBlock:(BJServiceErrorBlock)errorBlock;
@end
