#import "NSDateFormatter+DRExtension.h"
@implementation NSDateFormatter (DRExtension)
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
