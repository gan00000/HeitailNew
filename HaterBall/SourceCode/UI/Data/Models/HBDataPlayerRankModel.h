#import <Foundation/Foundation.h>
@interface HBDataPlayerRankModel : NSObject
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, assign) CGFloat pts;
@property (nonatomic, assign) CGFloat fgmade;
@property (nonatomic, assign) CGFloat fgatt;
@property (nonatomic, assign) CGFloat fg3ptmade;
@property (nonatomic, assign) CGFloat fg3ptatt;
@property (nonatomic, assign) CGFloat ftmade;
@property (nonatomic, assign) CGFloat ftatt;
@property (nonatomic, assign) CGFloat minseconds;
@property (nonatomic, copy) NSString *matches;
@property (nonatomic, assign) CGFloat reb;
@property (nonatomic, assign) CGFloat offreb;
@property (nonatomic, assign) CGFloat defreb;
@property (nonatomic, assign) CGFloat ast;
@property (nonatomic, assign) CGFloat fouls;
@property (nonatomic, assign) CGFloat stl;
@property (nonatomic, assign) CGFloat blk;
@property (nonatomic, assign) CGFloat turnover;
@property (nonatomic, copy) NSString *type_avg;
@property (nonatomic, copy) NSString *name;
@end
