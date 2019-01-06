#import <Foundation/Foundation.h>
@interface HBRankModel : NSObject
@property (nonatomic, copy) NSString *division;
@property (nonatomic, copy) NSString *teamId;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, assign) CGFloat pts;
@property (nonatomic, assign) NSInteger wins;
@property (nonatomic, assign) NSInteger Losses;
@property (nonatomic, assign) NSInteger losses;
@property (nonatomic, assign) CGFloat PtsAgainst;
@property (nonatomic, assign) CGFloat ptsagainst;
@property (nonatomic, assign) NSInteger GamesPlayed;
@property (nonatomic, assign) NSInteger gamesplayed;
@property (nonatomic, copy) NSString *season_name;
@property (nonatomic, copy) NSString *rank_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ch_name;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *ch_city;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *abbreviation;
@property (nonatomic, copy) NSString *team_logo;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, assign) NSInteger homewin;
@property (nonatomic, assign) NSInteger homelose;
@property (nonatomic, assign) NSInteger awaywin;
@property (nonatomic, assign) NSInteger awaylose;
@property (nonatomic, copy) NSString *win;
@property (nonatomic, copy) NSString *loss;
@property (nonatomic, copy) NSString *winRate;
@property (nonatomic, copy) NSString *home_matches;
@property (nonatomic, copy) NSString *away_matches;
@property (nonatomic, copy) NSString *area_matches;
@property (nonatomic, copy) NSString *avg_pts;
@property (nonatomic, copy) NSString *avg_against_pts;
@property (nonatomic, assign) NSInteger matches;
@property (nonatomic, assign) CGFloat against_pts;
@end
