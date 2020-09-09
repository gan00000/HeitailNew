//
//  ConfigCoreUtil.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "ConfigCoreUtil.h"
#import "AccountModel.h"


@interface ConfigCoreUtil()


@end

@implementation ConfigCoreUtil

static ConfigCoreUtil * configUtil;
static dispatch_once_t onceToken;

-(void)dealloc
{
    
}

+ (ConfigCoreUtil *)share
{
    
    dispatch_once(&onceToken,^{
        configUtil = [[ConfigCoreUtil alloc] init];
    });
    return configUtil;
}

- (instancetype)init
{
    self=[super init];
    if (self)
    {
        self.isSaveAccountInfo = YES;
    }
    return self;
}

//保存一个账号密码，如果存在，则更新，不存在则添加
-(void)saveAccount:(NSString *) mAccount password:(NSString *) password updateTime:(BOOL) updateTime
{
    
    NSArray *mAccountArray = [self getAccountModels];//获取保存的数据
    for (AccountModel *am in mAccountArray) {
        if ([am.accountName isEqualToString:mAccount]) {
            am.accountPwd = password;
            if (updateTime) {
                am.lastLoginTime = [self getTimeStamp];
            }
            [self saveAccountModels:mAccountArray];
            return;
        }
    }
    NSMutableArray *aar = [NSMutableArray arrayWithArray:mAccountArray];
    AccountModel *mAccountModel = [[AccountModel alloc] init];
    //赋值
    mAccountModel.lastLoginTime = [self getTimeStamp];
    mAccountModel.accountName = mAccount;
    mAccountModel.accountPwd = password;
    [aar addObject:mAccountModel];
    [self saveAccountModels:aar];
    
}

//保存一个账号密码，如果存在，则更新，不存在则添加
-(void)removeAccount:(NSString *) mAccount
{
    NSArray *mAccountArray = [self getAccountModels];//获取保存的数据
    NSMutableArray  *dataList = [NSMutableArray arrayWithArray:mAccountArray];
    for (AccountModel *am in dataList) {
        if ([am.accountName isEqualToString:mAccount]) {
            [dataList removeObject:am];
            [self saveAccountModels:dataList];
            return;
        }
    }
}

-(void)saveAccountModels:(NSArray<AccountModel *> *) mAccountModelArray
{
    
    NSMutableArray  *dataList = [NSMutableArray array];
    for (AccountModel *m in mAccountModelArray) {
        //存储到NSUserDefaults
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject: m];
        [dataList addObject: data];
    }
    
    //转为不可变数组才能保存
    NSArray *nsdataArray = [NSArray arrayWithArray: dataList];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nsdataArray forKey:@"Key_AccountModelArray"];
    [userDefaults synchronize];
}

-(NSMutableArray<AccountModel *> *)getAccountModels
{
    NSMutableArray  *accountModelList = [NSMutableArray array];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults objectForKey:@"Key_AccountModelArray"];
    for (NSData *data in array) {
        AccountModel *m = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [accountModelList addObject:m];
    }
    //根据创建时间排序
    [accountModelList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return -[((AccountModel *)obj1).lastLoginTime compare: ((AccountModel *)obj2).lastLoginTime];
    }];
    return accountModelList;
}

-(NSString *)getTimeStamp
{
    double secondTime=[[[NSDate alloc]init] timeIntervalSince1970];
    double millisecondTime=secondTime*1000;
    NSString * millisecondTimeStr=[NSString stringWithFormat:@"%f",millisecondTime];
    NSRange pointRange=[millisecondTimeStr rangeOfString:@"."];
    NSString * MSTime=[millisecondTimeStr substringToIndex:pointRange.location];
    
    return MSTime;
}


@end
