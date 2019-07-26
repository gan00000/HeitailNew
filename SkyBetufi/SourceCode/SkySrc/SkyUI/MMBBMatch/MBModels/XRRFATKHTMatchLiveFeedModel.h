//
//  XRRFATKHTMatchLiveFeedModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/23.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRRFATKHTMatchLiveFeedModel : NSObject

@property (nonatomic, copy) NSString *feed_id; // id
@property (nonatomic, copy) NSString *game_id;
@property (nonatomic, copy) NSString *quarter;
@property (nonatomic, copy) NSString *minutes;
@property (nonatomic, copy) NSString *seconds;
@property (nonatomic, copy) NSString *event_type;
@property (nonatomic, copy) NSString *team_abbr;
@property (nonatomic, copy) NSString *pts;
@property (nonatomic, copy) NSString *desc; // description
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *awayPts;
@property (nonatomic, copy) NSString *homePts;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *time;

@end

