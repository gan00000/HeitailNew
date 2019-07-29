//
//  XRRFATKHTUserManager.h
//  HeiteBasketball
//
//  Created by 冯生伟 on 2019/3/31.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKHTUserInfoModel.h"

extern const NSString * kUserLogStatusChagneNotice;

@interface XRRFATKHTUserManager : NSObject

// 判断用是否登录
+ (BOOL)skarg_isUserLogin;
// 獲取用戶信息
+ (XRRFATKHTUserInfoModel *)skarg_userInfo;

// token
+ (NSString *)skarg_userToken;
// 推送deviceToken
+ (NSString *)skarg_deviceToken;
+ (void)skarg_saveDeviceToken:(NSString *)deviceToken;

// 执行用户登录
+ (void)skarg_doUserLogin;
+ (void)skarg_doUserLogout;
+ (void)skarg_refreshUserInfoWithSuccessBlock:(dispatch_block_t)block;

// 媒體使用權限
+ (void)skargcameraDenied;
+ (void)skargphotoAlbumDenied;
+ (void)skarg_showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              cancelButton:(NSString *)cancelButton
             confirmButton:(NSString *)confirmButton
              confirmBlock:(dispatch_block_t)confirmBlock;

@end
