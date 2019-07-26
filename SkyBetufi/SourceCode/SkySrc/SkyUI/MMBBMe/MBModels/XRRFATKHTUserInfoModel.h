//
//  XRRFATKHTUserInfoModel.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/3/31.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 "user_id": 1,
 "display_name": "******",
 "change_name": "1",
 "user_email": "****@hotmail.com",
 "user_status": "0",
 "user_img": ""
 */

@interface XRRFATKHTUserInfoModel : NSObject

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *display_name;
@property (nonatomic, assign) BOOL change_name;
@property (nonatomic, copy) NSString *user_email;
@property (nonatomic, assign) NSInteger user_status; // 1封号，后台使用
@property (nonatomic, copy) NSString *user_img;
@property (nonatomic, strong) UIImage *avatar;

@end

NS_ASSUME_NONNULL_END
