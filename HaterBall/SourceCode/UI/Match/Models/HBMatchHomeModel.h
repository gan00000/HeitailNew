#import <Foundation/Foundation.h>
@interface HBMatchHomeModel : NSObject
@property (nonatomic, copy) NSString *game_id;
@property (nonatomic, copy) NSString *scheduleStatus;
@property (nonatomic, copy) NSString *originalDate;
@property (nonatomic, copy) NSString *originalTime;
@property (nonatomic, copy) NSString *delayedOrPostponedReason;
@property (nonatomic, copy) NSString *gametime;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *awayTeam;
@property (nonatomic, copy) NSString *homeTeam;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *season_name;
@property (nonatomic, assign) NSInteger game_status;
@property (nonatomic, copy) NSString *homeLogo;
@property (nonatomic, copy) NSString *homeName;
@property (nonatomic, copy) NSString *awayName;
@property (nonatomic, copy) NSString *awayLogo;
@property (nonatomic, copy) NSString *homeAbbr;
@property (nonatomic, copy) NSString *awayAbbr;
@property (nonatomic, copy) NSString *away_pts;
@property (nonatomic, copy) NSString *home_pts;
@property (nonatomic, copy) NSString *gamedate;
@property (nonatomic, copy) NSString *img_home_logo;
@property (nonatomic, copy) NSString *img_away_logo;
@property (nonatomic, copy) NSString *quarter;
@property (nonatomic, copy) NSString *quarter_time;
@end
