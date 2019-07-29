//
//  XRRFATKHTDataHomeModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/9/11.
//  Copyright © 2018年 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 team
 "Games": "10",
 "id": "26",
 "name": "Warriors",
 "ch_name": "勇士",
 "city": "Golden State",
 "ch_city": null,
 "logo": null,
 "abbreviation": "",
 "team_logo": "https://upload.wikimedia.org/wikipedia/en/0/01/Golden_State_Warriors_logo.svg",
 "score": "1241",
 "TeamID": "26",
 "teamName": "勇士",
 "matches": "10",
 "pts": "124.1000",
 "season_name": "2019"
 */

/*
 player
 "id": "20000485",
 "teamId": "26",
 "lastname": "Curry",
 "firstname": "Stephen",
 "jerseynumber": "30",
 "position": "PG",
 "height": "75",
 "weight": "190",
 "birthdate": "1988-03-14T00:00:00",
 "age": "",
 "birthcity": "Akron",
 "birthcountry": "",
 "isrookie": "",
 "isroster": null,
 "isactive": null,
 "officialImagesrc": "https://s3-us-west-2.amazonaws.com/static.fantasydata.com/headshots/nba/low-res/20000485.png",
 "score": "32.5000",
 "name": "Stephen Curry",
 "teamName": "勇士",
 "season_name": "2019"
 */

@interface XRRFATKHTDataHomeModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *officialImagesrc;
@property (nonatomic, copy) NSString *team_logo;
@property (nonatomic, copy) NSString *html_team_logo;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, assign) CGFloat pts;

- (void)skargimageUrlFixWithWidth:(NSInteger)width;

@end
