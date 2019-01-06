#import <Foundation/Foundation.h>
@interface NSNumber (ZGFormatter)
- (NSString *)roundDownFormat2Digit; 
- (NSString *)roundDownFormatMax2Digit; 
- (NSDecimalNumber *)decimalNumberWithMax2Digit;
- (NSString *)stringValueWithMax2Digit;
@end
