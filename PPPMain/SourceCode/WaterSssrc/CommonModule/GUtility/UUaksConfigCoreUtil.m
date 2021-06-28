//
//  UUaksConfigCoreUtil.m
//  CCSkyHourSDK
//
//  Created by ganyuanrong on 2019/5/29.
//  Copyright © 2019 ganyuanrong. All rights reserved.
//

#import "UUaksConfigCoreUtil.h"
#import "KSasxAccountModel.h"


@interface UUaksConfigCoreUtil()


@end

@implementation UUaksConfigCoreUtil

static UUaksConfigCoreUtil * configUtil;
static dispatch_once_t onceToken;

-(void)dealloc
{
    
}

+ (UUaksConfigCoreUtil *)share
{
    
    dispatch_once(&onceToken,^{
        configUtil = [[UUaksConfigCoreUtil alloc] init];
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
    for (KSasxAccountModel *am in mAccountArray) {
        if ([am.accountName isEqualToString:mAccount]) {
            am.accountPwd = password;
            if (updateTime) {
                am.lastLoginTime = [UUaksConfigCoreUtil getTimeStamp];
            }
            [self saveAccountModels:mAccountArray];
            return;
        }
    }
    NSMutableArray *aar = [NSMutableArray arrayWithArray:mAccountArray];
    KSasxAccountModel *mAccountModel = [[KSasxAccountModel alloc] init];
    //赋值
    mAccountModel.lastLoginTime = [UUaksConfigCoreUtil getTimeStamp];
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
    for (KSasxAccountModel *am in dataList) {
        if ([am.accountName isEqualToString:mAccount]) {
            [dataList removeObject:am];
            [self saveAccountModels:dataList];
            return;
        }
    }
}

-(void)saveAccountModels:(NSArray<KSasxAccountModel *> *) mAccountModelArray
{
    
    NSMutableArray  *dataList = [NSMutableArray array];
    for (KSasxAccountModel *m in mAccountModelArray) {
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

-(NSMutableArray<KSasxAccountModel *> *)getAccountModels
{
    NSMutableArray  *accountModelList = [NSMutableArray array];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults objectForKey:@"Key_AccountModelArray"];
    for (NSData *data in array) {
        KSasxAccountModel *m = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [accountModelList addObject:m];
    }
    //根据创建时间排序
    [accountModelList sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return -[((KSasxAccountModel *)obj1).lastLoginTime compare: ((KSasxAccountModel *)obj2).lastLoginTime];
    }];
    return accountModelList;
}

+(NSString *)getTimeStamp
{
    double secondTime=[[[NSDate alloc]init] timeIntervalSince1970];
    double millisecondTime=secondTime*1000;
    NSString * millisecondTimeStr=[NSString stringWithFormat:@"%f",millisecondTime];
    NSRange pointRange=[millisecondTimeStr rangeOfString:@"."];
    NSString * MSTime=[millisecondTimeStr substringToIndex:pointRange.location];
    
    return MSTime;
}

//获取当前时间
//- (NSString *)currentDateStr{
//    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
//    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS "];//设定时间格式,这里可以设置成自己需要的格式
//    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
//    return dateString;
//}

//获取当前时间戳
//- (NSString *)currentTimeStr{
//    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
//    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
//    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
//    return timeString;
//}


//字符串转时间戳 如：2017-4-10 17:15:10
+(NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm aa"]; //设定时间的格式
    NSLocale *usLocale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    dateFormatter.locale=usLocale;
    
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

@end
