#import "NSNumber+ZGFormatter.h"
@implementation NSNumber (ZGFormatter)
- (NSString *)roundDownFormat2Digit {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundDown];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMinimumIntegerDigits:1];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    return [numberFormatter stringFromNumber:self];
}
- (NSString *)roundDownFormatMax2Digit {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundDown];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMinimumIntegerDigits:1];
    [numberFormatter setMaximumFractionDigits:2];
    return [numberFormatter stringFromNumber:self];
}
- (NSDecimalNumber *)decimalNumberWithMax2Digit {
    return [NSDecimalNumber decimalNumberWithString:[self stringValueWithMax2Digit]];
}
- (NSString *)stringValueWithMax2Digit {
    NSNumberFormatter *formt = [[NSNumberFormatter alloc] init];
    [formt setMinimumIntegerDigits:1];
    [formt setMaximumFractionDigits:2];
    [formt setNumberStyle:NSNumberFormatterNoStyle];
    [formt setRoundingMode:NSNumberFormatterRoundFloor];
    return [formt stringFromNumber:self];
}
@end
