//
//  AccountModel.h
//  R2DSDK
//
//  Created by ganyuanrong on 2020/7/14.
//  Copyright © 2020 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountModel : NSObject<NSCoding>  //iOS对象序列化与反序列化

@property (nonatomic, copy) NSString *accountName;       // 名字
@property (nonatomic, copy) NSString *accountPwd;     // 用户ID
@property (nonatomic, copy) NSString *lastLoginTime;

@end

NS_ASSUME_NONNULL_END
