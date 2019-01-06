#import <Foundation/Foundation.h>
@interface NSString (JXDecimalCalculate)
+ (NSString *)jx_decimalAddWithAddendNumberString:(NSString *)addendNumberString addNumberString:(NSString *)addNumberString;
- (NSString *)jx_decimalAddWithAddNumberString:(NSString *)addNumberString;
+ (NSString *)jx_decimalSubtracteWithMinuendNumberString:(NSString *)minuendNumberString subtrahendNumberString:(NSString *)subtrahendNumberString;
- (NSString *)jx_decimalSubtracteWithSubtrahendNumberString:(NSString *)subtrahendNumberString;
+ (NSString *)jx_decimalMultiplyWithMultiplicandNumberString:(NSString *)multiplicandNumberString multiplierNumberString:(NSString *)multiplierNumberString;
- (NSString *)jx_decimalMultiplyWithMultiplierNumberString:(NSString *)multiplierNumberString;
+ (NSString *)jx_decimalDivideWithDividendNumberString:(NSString *)dividendNumberString divisorNumberString:(NSString *)divisorNumberString;
- (NSString *)jx_decimalDivideWithDivisorNumberString:(NSString *)divisorNumberString;
+ (NSComparisonResult)jx_compareWithFirstNumberString:(NSString *)firstNumberString secondNumberString:(NSString *)secondNumberString;
- (NSComparisonResult)jx_compareToNumberString:(NSString *)numberString;
- (BOOL)jx_lessThanNumberString:(NSString *)numberString;
- (BOOL)jx_lessThanOrEqualToNumberString:(NSString *)numberString;
- (BOOL)jx_greatThanNumberString:(NSString *)numberString;
- (BOOL)jx_greatThanOrEqualToNumberString:(NSString *)numberString;
- (NSString *)jx_decimalWithScale:(NSUInteger)scale;
@end
