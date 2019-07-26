//
//  XRRFATKHTDataPlayerRankModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/19.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "lastname": "James",
 "firstname": "LeBron",
 "teamName": "騎士",
 "pts": "748",
 "fgmade": "275",
 "fgatt": "510",
 "fg3ptmade": "39",
 "fg3ptatt": "114",
 "ftmade": "159",
 "ftatt": "213",
 "minseconds": "55302",
 "matches": "22",
 "reb": "201",
 "offreb": "32",
 "defreb": "169",
 "ast": "198",
 "fouls": "52",
 "stl": "30",
 "blk": "23",
 "turnover": "94",
 "type_avg": "34.0000"
 */

@interface XRRFATKHTDataPlayerRankModel : NSObject

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
