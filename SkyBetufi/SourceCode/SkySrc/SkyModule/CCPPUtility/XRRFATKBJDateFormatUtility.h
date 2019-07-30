#import <Foundation/Foundation.h>
@interface XRRFATKBJDateFormatUtility : NSObject
+ (NSString *)dateToShowFromDate:(NSDate *)date;
+ (NSString *)dateToShowFromDateString:(NSString *)dateString;
+ (NSString *)dateToShowFromDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat;
+ (NSString *)dateToShowFromTimeInterval:(NSTimeInterval)timeInterval;
@end