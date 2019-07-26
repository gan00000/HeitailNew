//
//  XRRFATKHTMyMessageModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/4/9.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 "post_id": "53663",
 "post_title": "NBA球員一套裝備價格是多少？….",
 "post_content": "有著頻繁身體接觸和高強度身體對抗的籃球運動，自然少不了五花八門的運動裝備，而作為世界上最頂級的籃球運動員的NBA球員，更是對裝備有著更高的要求，下面我們就來盤點NBA……",
 "post_guid": "http://www.ballgametime.com/?p=53663",
 "author": "21",
 "comment_id": "99",
 "comment_content": "TEST",
 "reply_msg": "",
 "type": "like",
 "read": "1",
 "created_on": "2019-02-01 17:35:10",
 "user_id": "21",
 "display_name": "Teh Jun Chuan",
 "user_img": "asbfcq!@#asva"
 */

@interface XRRFATKHTMyMessageModel : NSObject

@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *post_title;
@property (nonatomic, copy) NSString *post_content;
@property (nonatomic, copy) NSString *post_guide;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *comment_content;
@property (nonatomic, copy) NSString *reply_msg;
@property (nonatomic, copy) NSString *type; // like
@property (nonatomic, assign) BOOL read;
@property (nonatomic, copy) NSString *created_on;
@property (nonatomic, copy) NSString *display_name;
@property (nonatomic, copy) NSString *user_img;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSDate *date;

- (void)countHeight;


@end

NS_ASSUME_NONNULL_END
