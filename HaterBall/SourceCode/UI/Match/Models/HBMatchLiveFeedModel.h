#import <Foundation/Foundation.h>
@interface HBMatchLiveFeedModel : NSObject
@property (nonatomic, copy) NSString *feed_id; 
@property (nonatomic, copy) NSString *game_id;
@property (nonatomic, copy) NSString *quarter;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, copy) NSString *seconds;
@property (nonatomic, copy) NSString *event_type;
@property (nonatomic, copy) NSString *team_abbr;
@property (nonatomic, copy) NSString *pts;
@property (nonatomic, copy) NSString *desc; 
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *awayPts;
@property (nonatomic, copy) NSString *homePts;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *time;
@end
