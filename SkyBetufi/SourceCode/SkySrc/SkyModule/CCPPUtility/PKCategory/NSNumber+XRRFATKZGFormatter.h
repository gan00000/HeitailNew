#import <Foundation/Foundation.h>
@interface NSNumber (XRRFATKZGFormatter)
- (NSString *)roundDownFormat2Digit; 
- (NSString *)roundDownFormatMax2Digit; 
- (NSDecimalNumber *)decimalNumberWithMax2Digit;
- (NSString *)stringValueWithMax2Digit;
@end
