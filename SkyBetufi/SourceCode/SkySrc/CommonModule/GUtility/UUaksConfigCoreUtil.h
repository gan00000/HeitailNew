//
//  UUaksConfigCoreUtil.h
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSasxAccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UUaksConfigCoreUtil : NSObject

+ (UUaksConfigCoreUtil *)share;

@property (nonatomic) BOOL isSaveAccountInfo;
@property (copy,nonatomic) NSString *matchType;

-(void)saveAccount:(NSString *) mAccount password:(NSString *) password updateTime:(BOOL) updateTime;
-(void)removeAccount:(NSString *) mAccount;

-(void)saveAccountModels:(NSArray<KSasxAccountModel *> *) mAccountModelArray;

-(NSArray *)getAccountModels;

+(NSString *)getTimeStamp;

+(NSString *)getTimeStrWithString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
