//
//  XRRFATKHTMatchSummaryRequest.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/22.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import "XRRFATKHTMatchSummaryRequest.h"

@implementation XRRFATKHTMatchSummaryRequest

+ (void)skargrequestSummaryWithGameId:(NSString *)game_id
                    successBlock:(void(^)(XRRFATKHTMatchSummaryModel *summaryModel, XRRFATKHTMatchCompareModel *compareModel))successBlock
                      errorBlock:(BJServiceErrorBlock)errorBlock {
    [XRRFATKBJHTTPServiceEngine getRequestWithFunctionPath:API_MATCH_SUMMARY params:@{@"game_id":game_id} successBlock:^(id responseData) {
        XRRFATKHTMatchSummaryModel *summaryModel = [XRRFATKHTMatchSummaryModel yy_modelWithJSON:[responseData[@"match_summary"] firstObject]];
        XRRFATKHTMatchCompareModel *compareModel = [[XRRFATKHTMatchCompareModel alloc] init];
        NSMutableArray *homeTeamDetails = [NSMutableArray array];
        NSMutableArray *awayTeamDetails = [NSMutableArray array];
        
        compareModel.homeTeamDetails = homeTeamDetails;
        compareModel.awayTeamDetails = awayTeamDetails;
        
        NSArray *detailList = [NSArray yy_modelArrayWithClass:[XRRFATKHTMatchDetailsModel class] json:responseData[@"matchDetails"]];
        /// 主队篮板
        NSInteger home_team_reb = 0;
        /// 客队篮板
        NSInteger away_team_reb = 0;
        /// 主隊助攻
        NSInteger home_team_ast = 0;
        /// 客隊助攻
        NSInteger away_team_ast = 0;
        /// 主隊蓋帽
        NSInteger home_team_blk = 0;
        /// 客隊蓋帽
        NSInteger away_team_blk = 0;
        /// 主隊搶斷
        NSInteger home_team_stl = 0;
        /// 客隊搶斷
        NSInteger away_team_stl = 0;
        /// 主隊命中率
        NSInteger home_team_fgatt = 0;
        NSInteger home_team_fgmade = 0;
        /// 客隊命中率
        NSInteger away_team_fgatt = 0;
        NSInteger away_team_fgmade = 0;
        /// 主隊3分命中率
        NSInteger home_team_fg3ptatt = 0;
        NSInteger home_team_fg3ptmade = 0;
        /// 客隊3分命中率
        NSInteger away_team_fg3ptatt = 0;
        NSInteger away_team_fg3ptmade = 0;
        /// 主隊罰籃命中率
        NSInteger home_team_ftatt = 0;
        NSInteger home_team_ftmade = 0;
        /// 客隊罰籃命中率
        NSInteger away_team_ftatt = 0;
        NSInteger away_team_ftmade = 0;
        
        /// 主隊得分最高球員
        XRRFATKHTMatchDetailsModel *home_team_pts_most = nil;
        /// 客隊得分最高球員
        XRRFATKHTMatchDetailsModel *away_team_pts_most = nil;
        /// 主隊助攻最高球員
        XRRFATKHTMatchDetailsModel *home_team_ast_most = nil;
        /// 客隊助攻最高球員
        XRRFATKHTMatchDetailsModel *away_team_ast_most = nil;
        /// 主隊籃板最高球員
        XRRFATKHTMatchDetailsModel *home_team_reb_most = nil;
        /// 客隊籃板最高球員
        XRRFATKHTMatchDetailsModel *away_team_reb_most = nil;
        
        for (XRRFATKHTMatchDetailsModel *model in detailList) {
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
