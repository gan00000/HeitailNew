#import "HBBJDateFormatUtility.h"
#import "NSDateFormatter+DRExtension.h"
@implementation HBBJDateFormatUtility
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
+ (NSString *)dateToShowFromDateString:(NSString *)dateString {
    NSDateFormatter *formt = [NSDateFormatter dr_dateFormatter];
    [formt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [self dateToShowFromDate:[formt dateFromString:dateString]];
}
+ (NSString *)dateToShowFromDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [NSDateFormatter dr_dateFormatter];
    [formatter setDateFormat:dateFormat];
    return [HBBJDateFormatUtility dateToShowFromDate:[formatter dateFromString:dateString]];
}
+ (NSString *)dateToShowFromTimeInterval:(NSTimeInterval)timeInterval {
    return [HBBJDateFormatUtility dateToShowFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}
@end
