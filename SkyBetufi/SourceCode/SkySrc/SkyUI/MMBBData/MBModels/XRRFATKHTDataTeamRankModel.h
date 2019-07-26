//
//  XRRFATKHTDataTeamRankModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "teamName": "勇士",
 "team_logo": "https://upload.wikimedia.org/wikipedia/en/0/01/Golden_State_Warriors_logo.svg",
 "pts": "2319",
 "reb": "946",
 "ast": "548",
 "stl": "165",
 "blk": "122",
 "fouls": "414",
 "fgmade": "866",
 "fgatt": "1807",
 "fg3ptmade": "235",
 "fg3ptatt": "659",
 "ftmade": "352",
 "ftatt": "428",
 "matches": "21",
 "type_avg": "110.4286"
 */

@interface XRRFATKHTDataTeamRankModel : NSObject

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
