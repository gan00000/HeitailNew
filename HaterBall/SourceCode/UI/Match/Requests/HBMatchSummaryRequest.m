#import "HBMatchSummaryRequest.h"
@implementation HBMatchSummaryRequest
+ (void)requestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(HBMatchSummaryModel *summaryModel, HBMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock {
    [HBBJHTTPServiceEngine getRequestWithFunctionPath:API_MATCH_SUMMARY params:@{@"game_id":game_id} successBlock:^(id responseData) {
        HBMatchSummaryModel *summaryModel = [HBMatchSummaryModel yy_modelWithJSON:[responseData[@"match_summary"] firstObject]];
        HBMatchCompareModel *compareModel = [[HBMatchCompareModel alloc] init];
        NSMutableArray *homeTeamDetails = [NSMutableArray array];
        NSMutableArray *awayTeamDetails = [NSMutableArray array];
        compareModel.homeTeamDetails = homeTeamDetails;
        compareModel.awayTeamDetails = awayTeamDetails;
        NSArray *detailList = [NSArray yy_modelArrayWithClass:[HBMatchDetailsModel class] json:responseData[@"matchDetails"]];
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
        HBMatchDetailsModel *home_team_pts_most = nil;
        HBMatchDetailsModel *away_team_pts_most = nil;
        HBMatchDetailsModel *home_team_ast_most = nil;
        HBMatchDetailsModel *away_team_ast_most = nil;
        HBMatchDetailsModel *home_team_reb_most = nil;
        HBMatchDetailsModel *away_team_reb_most = nil;
        for (HBMatchDetailsModel *model in detailList) {
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
        summaryModel.home_team_fgmade = @"0.00%";
        if (home_team_fgatt > 0) {
            summaryModel.home_team_fgmade = [NSString stringWithFormat:@"%.2f%%", 100.0 * home_team_fgmade / home_team_fgatt];
        }
        summaryModel.away_team_fgmade = @"0.00%";
        if (away_team_fgatt > 0) {
            summaryModel.away_team_fgmade = [NSString stringWithFormat:@"%.2f%%", 100.0 * away_team_fgmade / away_team_fgatt];
        }
        summaryModel.home_team_fg3ptmade = @"0.00%";
        if (home_team_fg3ptatt > 0) {
            summaryModel.home_team_fg3ptmade = [NSString stringWithFormat:@"%.2f%%", 100.0 * home_team_fg3ptmade / home_team_fg3ptatt];
        }
        summaryModel.away_team_fg3ptmade = @"0.00%";
        if (away_team_fg3ptatt > 0) {
            summaryModel.away_team_fg3ptmade = [NSString stringWithFormat:@"%.2f%%", 100.0 * away_team_fg3ptmade / away_team_fg3ptatt];
        }
        summaryModel.home_team_ftmade = @"0.00%";
        if (home_team_ftatt > 0) {
            summaryModel.home_team_ftmade = [NSString stringWithFormat:@"%.2f%%", 100.0 * home_team_ftmade / home_team_ftatt];
        }
        summaryModel.away_team_ftmade = @"0.00%";
        if (away_team_ftatt > 0) {
            summaryModel.away_team_ftmade = [NSString stringWithFormat:@"%.2f%%", 100.0 * away_team_ftmade / away_team_ftatt];
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
@end
