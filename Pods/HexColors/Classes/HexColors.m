#import "HexColors.h"
@implementation HXColor (HexColorAddition)
+ (HXColor *)hx_colorWithHexString:(NSString *)hexString
{
    return [[self class] hx_colorWithHexString:hexString alpha:1.0];
}
+ (HXColor *)hx_colorWithHexRGBAString:(NSString *)hexString
{
    return [[self class] hx_colorWithHexRGBAString:hexString alpha:1.0];
}
+ (HXColor *)hx_colorWithHexRGBAString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if (hexString.length == 0) {
        return nil;
    }
    if('#' != [hexString characterAtIndex:0]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    NSArray *validHexStringLengths = @[@4, @5, @7, @9];
    NSNumber *hexStringLengthNumber = [NSNumber numberWithUnsignedInteger:hexString.length];
    if ([validHexStringLengths indexOfObject:hexStringLengthNumber] == NSNotFound) {
        return nil;
    }
    CGFloat handedInAlpha = alpha;
    if (5 == hexString.length || 9 == hexString.length) {
        NSString *alphaHex;
        if (5 == hexString.length) {
            alphaHex = [hexString substringWithRange:NSMakeRange(4, 1)];
        } else {
            alphaHex = [hexString substringWithRange:NSMakeRange(7, 2)];
        }
        if (1 == alphaHex.length) alphaHex = [NSString stringWithFormat:@"%@%@", alphaHex, alphaHex];
        hexString = [NSString stringWithFormat:@"#%@", [hexString substringWithRange:NSMakeRange(1, 9 == hexString.length ? 6 : 3)]];
        unsigned alpha_u = [[self class] hx_hexValueToUnsigned:alphaHex];
        handedInAlpha = ((CGFloat) alpha_u) / 255.0;
    }
    hexString = [hexString hx_hexStringTransformFromThreeCharacters];
    NSString *redHex    = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [[self class] hx_hexValueToUnsigned:redHex];
    NSString *greenHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [[self class] hx_hexValueToUnsigned:greenHex];
    NSString *blueHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [[self class] hx_hexValueToUnsigned:blueHex];
    HXColor *color = [HXColor hx_colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:handedInAlpha];
    return color;
}
+ (HXColor *)hx_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if (hexString.length == 0) {
        return nil;
    }
    if('#' != [hexString characterAtIndex:0]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    NSArray *validHexStringLengths = @[@4, @5, @7, @9];
    NSNumber *hexStringLengthNumber = [NSNumber numberWithUnsignedInteger:hexString.length];
    if ([validHexStringLengths indexOfObject:hexStringLengthNumber] == NSNotFound) {
        return nil;
    }
    CGFloat handedInAlpha = alpha;
    if (5 == hexString.length || 9 == hexString.length) {
        NSString * alphaHex = [hexString substringWithRange:NSMakeRange(1, 9 == hexString.length ? 2 : 1)];
        if (1 == alphaHex.length) alphaHex = [NSString stringWithFormat:@"%@%@", alphaHex, alphaHex];
        hexString = [NSString stringWithFormat:@"#%@", [hexString substringFromIndex:9 == hexString.length ? 3 : 2]];
        unsigned alpha_u = [[self class] hx_hexValueToUnsigned:alphaHex];
        handedInAlpha = ((CGFloat) alpha_u) / 255.0;
    }
    hexString = [hexString hx_hexStringTransformFromThreeCharacters];
    NSString *redHex    = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [[self class] hx_hexValueToUnsigned:redHex];
    NSString *greenHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [[self class] hx_hexValueToUnsigned:greenHex];
    NSString *blueHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [[self class] hx_hexValueToUnsigned:blueHex];
    HXColor *color = [HXColor hx_colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:handedInAlpha];
    return color;
}
+ (HXColor *)hx_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
    return [[self class] hx_colorWith8BitRed:red green:green blue:blue alpha:1.0];
}
+ (HXColor *)hx_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    HXColor *color = nil;
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
    color = [HXColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#else
    color = [HXColor colorWithCalibratedRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#endif
    return color;
}
+ (unsigned)hx_hexValueToUnsigned:(NSString *)hexValue
{
    unsigned value = 0;
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    return value;
}
@end
@implementation NSString (hx_StringTansformer)
- (NSString *)hx_hexStringTransformFromThreeCharacters;
{
    if(self.length == 4)
    {
        NSString * hexString = [NSString stringWithFormat:@"#%1$c%1$c%2$c%2$c%3$c%3$c",
                                [self characterAtIndex:1],
                                [self characterAtIndex:2],
                                [self characterAtIndex:3]];
        return hexString;
    }
    return self;
}
@end
