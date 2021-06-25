#import "MMoogHTMatchSummaryRequest.h"
#import "KSasxHTMacthLivePostModel.h"
#import "BByasHTLikeTeamModel.h"


@implementation MMoogHTMatchSummaryRequest
+ (void)taorequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(KSasxHTMatchSummaryModel *summaryModel, BByasHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_SUMMARY params:@{@"game_id":game_id} successBlock:^(id responseData) {
        KSasxHTMatchSummaryModel *summaryModel = [KSasxHTMatchSummaryModel yy_modelWithJSON:[responseData[@"match_summary"] firstObject]];
        BByasHTMatchCompareModel *compareModel = [[BByasHTMatchCompareModel alloc] init];
        NSMutableArray *homeTeamDetails = [NSMutableArray array];
        NSMutableArray *awayTeamDetails = [NSMutableArray array];
        compareModel.homeTeamDetails = homeTeamDetails;
        compareModel.awayTeamDetails = awayTeamDetails;
        NSArray *detailList = [NSArray yy_modelArrayWithClass:[UUaksHTMatchDetailsModel class] json:responseData[@"matchDetails"]];
        NSInteger home_team_reb = 0;
        NSInteger away_team_reb = 0;
        NSInteger home_team_ast = 0;
        NSInteger away_team_ast = 0;
        NSInteger home_team_blk = 0;
        NSInteger away_team_blk = 0;
        NSInteger home_team_stl = 0;
        NSInteger away_team_stl = 0;
        NSInteger home_team_fgatt = 0;
        NSInteger home_team_fgmade = 0;
        NSInteger away_team_fgatt = 0;
        NSInteger away_team_fgmade = 0;
        NSInteger home_team_fg3ptatt = 0;
        NSInteger home_team_fg3ptmade = 0;
        NSInteger away_team_fg3ptatt = 0;
        NSInteger away_team_fg3ptmade = 0;
        NSInteger home_team_ftatt = 0;
        NSInteger home_team_ftmade = 0;
        NSInteger away_team_ftatt = 0;
        NSInteger away_team_ftmade = 0;
        UUaksHTMatchDetailsModel *home_team_pts_most = nil;
        UUaksHTMatchDetailsModel *away_team_pts_most = nil;
        UUaksHTMatchDetailsModel *home_team_ast_most = nil;
        UUaksHTMatchDetailsModel *away_team_ast_most = nil;
        UUaksHTMatchDetailsModel *home_team_reb_most = nil;
        UUaksHTMatchDetailsModel *away_team_reb_most = nil;
        for (UUaksHTMatchDetailsModel *model in detailList) {
            if ([model.teamId isEqualToString:summaryModel.awayTeam]) {
                [awayTeamDetails addObject:model];
                away_team_reb += model.reb.integerValue;
                away_team_ast += model.ast.integerValue;
                away_team_blk += model.blk.integerValue;
                away_team_stl += model.stl.integerValue;
                away_team_fgatt += model.fgatt.integerValue;
                away_team_fgmade += model.fgmade.integerValue;
                away_team_fg3ptatt += model.fg3ptatt.integerValue;
                away_team_fg3ptmade += model.fg3ptmade.integerValue;
                away_team_ftatt += model.ftatt.integerValue;
                away_team_ftmade += model.ftmade.integerValue;
                if (model.pts.integerValue > away_team_pts_most.pts.integerValue) {
                    away_team_pts_most = model;
                }
                if (model.ast.integerValue > away_team_ast_most.ast.integerValue) {
                    away_team_ast_most = model;
                }
                if (model.reb.integerValue > away_team_reb_most.reb.integerValue) {
                    away_team_reb_most = model;
                }
            } else {
                [homeTeamDetails addObject:model];
                home_team_reb += model.reb.integerValue;
                home_team_ast += model.ast.integerValue;
                home_team_blk += model.blk.integerValue;
                home_team_stl += model.stl.integerValue;
                home_team_fgatt += model.fgatt.integerValue;
                home_team_fgmade += model.fgmade.integerValue;
                home_team_fg3ptatt += model.fg3ptatt.integerValue;
                home_team_fg3ptmade += model.fg3ptmade.integerValue;
                home_team_ftatt += model.ftatt.integerValue;
                home_team_ftmade += model.ftmade.integerValue;
                if (model.pts.integerValue > home_team_pts_most.pts.integerValue) {
                    home_team_pts_most = model;
                }
                if (model.ast.integerValue > home_team_ast_most.ast.integerValue) {
                    home_team_ast_most = model;
                }
                if (model.reb.integerValue > home_team_reb_most.reb.integerValue) {
                    home_team_reb_most = model;
                }
            }
        }
        summaryModel.home_team_reb = [NSString stringWithFormat:@"%ld", home_team_reb];
        summaryModel.away_team_reb = [NSString stringWithFormat:@"%ld", away_team_reb];
        summaryModel.home_team_ast = [NSString stringWithFormat:@"%ld", home_team_ast];
        summaryModel.away_team_ast = [NSString stringWithFormat:@"%ld", away_team_ast];
        summaryModel.home_team_blk = [NSString stringWithFormat:@"%ld", home_team_blk];
        summaryModel.away_team_blk = [NSString stringWithFormat:@"%ld", away_team_blk];
        summaryModel.home_team_stl = [NSString stringWithFormat:@"%ld", home_team_stl];
        summaryModel.away_team_stl = [NSString stringWithFormat:@"%ld", away_team_stl];
        summaryModel.home_team_fgmade = @"0%";
        if (home_team_fgatt > 0) {
            summaryModel.home_team_fgmade = [NSString stringWithFormat:@"%ld%%", (NSInteger)(100.0 * home_team_fgmade / home_team_fgatt)];
        }
        summaryModel.away_team_fgmade = @"0%";
        if (away_team_fgatt > 0) {
            summaryModel.away_team_fgmade = [NSString stringWithFormat:@"%ld%%", (NSInteger)(100.0 * away_team_fgmade / away_team_fgatt)];
        }
        summaryModel.home_team_fg3ptmade = @"0%";
        if (home_team_fg3ptatt > 0) {
            summaryModel.home_team_fg3ptmade = [NSString stringWithFormat:@"%ld%%", (NSInteger)(100.0 * home_team_fg3ptmade / home_team_fg3ptatt)];
        }
        summaryModel.away_team_fg3ptmade = @"0%";
        if (away_team_fg3ptatt > 0) {
            summaryModel.away_team_fg3ptmade = [NSString stringWithFormat:@"%ld%%", (NSInteger)(100.0 * away_team_fg3ptmade / away_team_fg3ptatt)];
        }
        summaryModel.home_team_ftmade = @"0%";
        if (home_team_ftatt > 0) {
            summaryModel.home_team_ftmade = [NSString stringWithFormat:@"%ld%%", (NSInteger)(100.0 * home_team_ftmade / home_team_ftatt)];
        }
        summaryModel.away_team_ftmade = @"0%";
        if (away_team_ftatt > 0) {
            summaryModel.away_team_ftmade = [NSString stringWithFormat:@"%ld%%", (NSInteger)(100.0 * away_team_ftmade / away_team_ftatt)];
        }
        summaryModel.home_team_pts_most = home_team_pts_most;
        summaryModel.home_team_ast_most = home_team_ast_most;
        summaryModel.home_team_reb_most = home_team_reb_most;
        summaryModel.away_team_pts_most = away_team_pts_most;
        summaryModel.away_team_ast_most = away_team_ast_most;
        summaryModel.away_team_reb_most = away_team_reb_most;
        if (successBlock) {
            successBlock(summaryModel, compareModel);
        }
    } errorBlock:errorBlock];
}

+ (void)requestLivePostWithGameId:(NSString *)game_id
                successBlock:(void(^)(KSasxHTMacthLivePostModel * livePost))successBlock
                  errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_LIVE_POST params:@{@"game_id":game_id} successBlock:^(id responseData) {
        
        KSasxHTMacthLivePostModel *livePost = [KSasxHTMacthLivePostModel yy_modelWithJSON:[responseData[@"result"] firstObject]];
        if (successBlock) {
            successBlock(livePost);
        }
        
    } errorBlock:errorBlock];
    
 }


//http://app.ballgametime.com/api/like_match_team/?game_id=3555239&type=1 點讚接口
// game_id 比赛赛程id
//type   1-主队;2-客队
+ (void)requestLikeMatchTeamWithGameId:(NSString *)game_id
                                  type:(NSString *)type
               successBlock:(void(^)(BByasHTLikeTeamModel * m))successBlock
                 errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_LIKE_MATCH_TEAM params:@{@"game_id":game_id, @"type": type} successBlock:^(id responseData) {
       
       BByasHTLikeTeamModel *mHTLikeTeamModel = [BByasHTLikeTeamModel yy_modelWithJSON: responseData[@"team_like"]];
       if (successBlock) {
           successBlock(mHTLikeTeamModel);
       }
       
   } errorBlock:errorBlock];
   
}
///api/get_player_match_summary/  game_id") String gameId,@Query("team_id") String team_id,@Query("player_id")

+ (void)requestPlayerInfo:(NSString *)game_id
                  teamId:(NSString *)team_id
                playerId:(NSString *)player_id
               successBlock:(void(^)(NSArray<UUaksHTMatchDetailsModel *> * model))successBlock
                 errorBlock:(BJServiceErrorBlock)errorBlock {
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_PLAYER_INFO params:@{@"game_id":game_id, @"team_id": team_id, @"player_id": player_id} successBlock:^(id responseData) {
       
        NSArray *models = [NSArray yy_modelArrayWithClass:[UUaksHTMatchDetailsModel class] json:responseData[@"matchDetails"]];
       if (successBlock) {
           successBlock(models);
       }
       
   } errorBlock:errorBlock];
   
}


+ (void)getShootPointWithGameId:(NSString *)game_id
            home_away:(NSString *)home_away //1-主队 2-客队
                playerId:(NSString *)player_id
                 quarter:(NSString *)quarter //小节数，如：1,2,3,4
               successBlock:(void(^)(NSArray<TuTuosHotShootPointModel *> * model))successBlock
                 errorBlock:(BJServiceErrorBlock)errorBlock
{
    
    [NSNiceBJHTTPServiceEngine tao_getRequestWithFunctionPath:API_MATCH_GET_SHOOT_POINT params:@{@"game_id":game_id, @"home_away": home_away, @"player_id": player_id, @"quarter":quarter} successBlock:^(id responseData) {

        NSArray *models = [NSArray yy_modelArrayWithClass:[TuTuosHotShootPointModel class] json:responseData[@"result"]];
            if (successBlock) {
                successBlock(models);
            }

        } errorBlock:errorBlock];
}

@end
