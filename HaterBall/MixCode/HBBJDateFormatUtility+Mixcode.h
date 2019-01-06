#import <Foundation/Foundation.h>
#import "HBBJDateFormatUtility.h"
#import "NSDateFormatter+DRExtension.h"

@interface HBBJDateFormatUtility (Mixcode)
+ (void)dateToShowFromDate:(NSDate *)date mixcode:(NSString *)mixcode;
+ (void)dateToShowFromDateString:(NSString *)dateString mixcode:(NSString *)mixcode;
+ (void)dateToShowFromDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat mixcode:(NSString *)mixcode;
+ (void)dateToShowFromTimeInterval:(NSTimeInterval)timeInterval mixcode:(NSString *)mixcode;

@end
