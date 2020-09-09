//
//  ConfigCoreUtil.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfigCoreUtil : NSObject

+ (ConfigCoreUtil *)share;

@property (nonatomic) BOOL isSaveAccountInfo;

-(void)saveAccount:(NSString *) mAccount password:(NSString *) password updateTime:(BOOL) updateTime;
-(void)removeAccount:(NSString *) mAccount;

-(void)saveAccountModels:(NSArray<AccountModel *> *) mAccountModelArray;

-(NSArray *)getAccountModels;

@end

NS_ASSUME_NONNULL_END
