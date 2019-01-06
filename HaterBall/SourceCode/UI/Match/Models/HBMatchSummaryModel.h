#import <Foundation/Foundation.h>
#import "HBMatchDetailsModel.h"
@interface HBMatchSummaryModel : NSObject
@property (nonatomic, copy) NSString *homeLogo;
@property (nonatomic, copy) NSString *awayLogo;
@property (nonatomic, copy) NSString *homeName;
@property (nonatomic, copy) NSString *awayName;
@property (nonatomic, copy) NSString *homeTeam;
@property (nonatomic, copy) NSString *awayTeam;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *scheduleStatus;
@property (nonatomic, copy) NSString *away_pts;
@property (nonatomic, copy) NSString *home_pts;
@property (nonatomic, copy) NSString *away_quarter_scores;
@property (nonatomic, copy) NSString *home_quarter_scores;
@property (nonatomic, assign) NSInteger game_status;
@property (nonatomic, copy) NSString *quarter;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, copy) NSString *seconds;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *img_home_logo;
@property (nonatomic, copy) NSString *img_away_logo;
@property (nonatomic, copy) NSString *home_team_reb;
@property (nonatomic, copy) NSString *away_team_reb;
@property (nonatomic, copy) NSString *home_team_ast;
@property (nonatomic, copy) NSString *away_team_ast;
@property (nonatomic, copy) NSString *home_team_blk;
@property (nonatomic, copy) NSString *away_team_blk;
@property (nonatomic, copy) NSString *home_team_stl;
@property (nonatomic, copy) NSString *away_team_stl;
@property (nonatomic, copy) NSString *home_team_fgmade;
@property (nonatomic, copy) NSString *away_team_fgmade;
@property (nonatomic, copy) NSString *home_team_fg3ptmade;
@property (nonatomic, copy) NSString *away_team_fg3ptmade;
@property (nonatomic, copy) NSString *home_team_ftmade;
@property (nonatomic, copy) NSString *away_team_ftmade;
@property (nonatomic, weak) HBMatchDetailsModel *home_team_pts_most;
@property (nonatomic, weak) HBMatchDetailsModel *away_team_pts_most;
@property (nonatomic, weak) HBMatchDetailsModel *home_team_ast_most;
@property (nonatomic, weak) HBMatchDetailsModel *away_team_ast_most;
@property (nonatomic, weak) HBMatchDetailsModel *home_team_reb_most;
@property (nonatomic, weak) HBMatchDetailsModel *away_team_reb_most;
@end
