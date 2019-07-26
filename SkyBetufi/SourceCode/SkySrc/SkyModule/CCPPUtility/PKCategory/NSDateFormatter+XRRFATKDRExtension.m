//
//  NSDateFormatter+XRRFATKDRExtension.m
//  Records
//
//  Created by LiuHao on 2018/6/27.
//  Copyright © 2018年 DuoRong Technology Co., Ltd. All rights reserved.
//

#import "NSDateFormatter+XRRFATKDRExtension.h"

@implementation NSDateFormatter (XRRFATKDRExtension)

+ (instancetype)dr_dateFormatter {
    static NSDateFormatter* dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[self alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_cn"]];
    });
    return dateFormatter;
}

@end
