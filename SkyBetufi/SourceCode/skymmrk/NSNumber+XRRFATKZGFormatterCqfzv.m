#import "NSNumber+XRRFATKZGFormatterCqfzv.h"
@implementation NSNumber (XRRFATKZGFormatterCqfzv)
+ (BOOL)roundDownFormat2DigitCqfzv:(NSInteger)Cqfzv {
    return Cqfzv % 40 == 0;
}
+ (BOOL)roundDownFormatMax2DigitCqfzv:(NSInteger)Cqfzv {
    return Cqfzv % 41 == 0;
}
+ (BOOL)decimalNumberWithMax2DigitCqfzv:(NSInteger)Cqfzv {
    return Cqfzv % 32 == 0;
}
+ (BOOL)stringValueWithMax2DigitCqfzv:(NSInteger)Cqfzv {
    return Cqfzv % 12 == 0;
}

@end
