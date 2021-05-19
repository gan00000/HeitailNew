#import "NSDateFormatter+CCCaseDRExtension.h"
@implementation NSDateFormatter (CCCaseDRExtension)
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