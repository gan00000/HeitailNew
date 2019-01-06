#import <Foundation/Foundation.h>
@interface HBDataTeamRankModel : NSObject
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *team_logo;
@property (nonatomic, assign) CGFloat pts;
@property (nonatomic, assign) CGFloat reb;
@property (nonatomic, assign) CGFloat ast;
@property (nonatomic, assign) CGFloat stl;
@property (nonatomic, assign) CGFloat blk;
@property (nonatomic, assign) CGFloat fouls;
@property (nonatomic, assign) CGFloat fgmade;
@property (nonatomic, assign) CGFloat fgatt;
@property (nonatomic, assign) CGFloat fg3ptmade;
@property (nonatomic, assign) CGFloat fg3ptatt;
@property (nonatomic, assign) CGFloat ftmade;
@property (nonatomic, assign) CGFloat ftatt;
@property (nonatomic, copy) NSString *matches;
@property (nonatomic, copy) NSString *type_avg;
@end
