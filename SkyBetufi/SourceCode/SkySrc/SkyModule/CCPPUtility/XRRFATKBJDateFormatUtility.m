//
//  XRRFATKBJDateFormatUtility.m
//  BenjiaPro
//
//  Created by JZ_Stone on 2017/9/18.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKBJDateFormatUtility.h"
#import "NSDateFormatter+XRRFATKDRExtension.h"

@implementation XRRFATKBJDateFormatUtility

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromDate:(NSDate *)date {
    if (!date || ![date isKindOfClass:[NSDate class]]) {
        return nil;
    }
    
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:nowDate options:0];
    
    if (cmps.day == 0) {
        if (cmps.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小時前", cmps.hour];
        } else if (cmps.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分鐘前", cmps.minute];
        } else if (cmps.second >= 1) {
            return [NSString stringWithFormat:@"%ld秒鐘前", cmps.second];
        } else {
            return @"刚刚";
        }
    } else {
        return [NSString stringWithFormat:@"%ld天前", cmps.day];
    }
}

/*
 *  得到用于显示的时间，字符串格式 yyyy-MM-dd
 *
 *  @param date 来自后台需要转换的原始时间字符串
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromDateString:(NSString *)dateString {
    NSDateFormatter *formt = [NSDateFormatter dr_dateFormatter];
    [formt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [self dateToShowFromDate:[formt dateFromString:dateString]];
}

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间
 *  @param dateFormat 来自后台时间的时间格式 如 MM/dd/YYYY HH:mm:ss
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [NSDateFormatter dr_dateFormatter];
    [formatter setDateFormat:dateFormat];
    return [XRRFATKBJDateFormatUtility dateToShowFromDate:[formatter dateFromString:dateString]];
}

/*
 *  得到用于显示的时间，如 12:33， 昨天10:21， 9月18日 10:31
 *
 *  @param date 来自后台需要转换的原始时间
 *  @return 用于显示的时间
 */
+ (NSString *)dateToShowFromTimeInterval:(NSTimeInterval)timeInterval {
    return [XRRFATKBJDateFormatUtility dateToShowFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

@end
