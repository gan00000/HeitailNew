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
+ (BOOL)isUserLogin;
// 獲取用戶信息
+ (XRRFATKHTUserInfoModel *)userInfo;

// token
+ (NSString *)userToken;
// 推送deviceToken
+ (NSString *)deviceToken;
+ (void)saveDeviceToken:(NSString *)deviceToken;

// 执行用户登录
+ (void)doUserLogin;
+ (void)doUserLogout;
+ (void)refreshUserInfoWithSuccessBlock:(dispatch_block_t)block;

// 媒體使用權限
+ (void)cameraDenied;
+ (void)photoAlbumDenied;
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              cancelButton:(NSString *)cancelButton
             confirmButton:(NSString *)confirmButton
              confirmBlock:(dispatch_block_t)confirmBlock;

@end
