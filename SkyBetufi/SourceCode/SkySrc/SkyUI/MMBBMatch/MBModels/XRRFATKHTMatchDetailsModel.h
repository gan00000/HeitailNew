//
//  XRRFATKHTMatchDetailsModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/10/10.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRRFATKHTMatchDetailsModel : NSObject

@property (nonatomic, copy) NSString *gameId;
@property (nonatomic, copy) NSString *playerId;
@property (nonatomic, copy) NSString *teamId;
@property (nonatomic, copy) NSString *pts;
@property (nonatomic, assign) NSInteger minseconds;
@property (nonatomic, copy) NSString *ast;
@property (nonatomic, copy) NSString *reb;
/// 前场
@property (nonatomic, copy) NSString *offreb;
/// 后场
@property (nonatomic, copy) NSString *defreb;
/// 犯规
@property (nonatomic, copy) NSString *fouls;
/// 盖帽
@property (nonatomic, copy) NSString *blk;
/// 抢断
@property (nonatomic, copy) NSString *stl;
/// 失误
@property (nonatomic, copy) NSString *blkagainst;
/// +/-
@property (nonatomic, copy) NSString *plusminus;
@property (nonatomic, copy) NSString *detail_id;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *jerseynumber;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *birthdate;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *birthcity;
@property (nonatomic, copy) NSString *birthcountry;
@property (nonatomic, copy) NSString *isrookie;
@property (nonatomic, copy) NSString *isroster;
@property (nonatomic, copy) NSString *isactive;
@property (nonatomic, copy) NSString *officialImagesrc;
@property (nonatomic, copy) NSString *isStarter;

// 投籃
@property (nonatomic, copy) NSString *fgatt;
@property (nonatomic, copy) NSString *fgmade;
/// 投籃
@property (nonatomic, copy) NSString *fgmade_show;
// 三分
@property (nonatomic, copy) NSString *fg3ptatt;
@property (nonatomic, copy) NSString *fg3ptmade;
/// 三分
@property (nonatomic, copy) NSString *fg3ptmade_show;
// 發球
@property (nonatomic, copy) NSString *ftatt;
@property (nonatomic, copy) NSString *ftmade;
/// 發球
@property (nonatomic, copy) NSString *ftmade_show;
@property (nonatomic, copy) NSString *name;

/// 上场时间
@property (nonatomic, copy) NSString *time;


@end
