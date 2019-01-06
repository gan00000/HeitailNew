#import "TargetConditionals.h"
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
  #import <UIKit/UIKit.h>
  #define HXColor UIColor
#else
  #import <Cocoa/Cocoa.h>
  #define HXColor NSColor
#endif
@interface HXColor (HexColorAddition)
+ (nullable HXColor *)hx_colorWithHexString:(nonnull NSString *)hexString __attribute__ ((deprecated("Use '-hx_colorWithHexRGBAString' instead.")));
+ (nullable HXColor *)hx_colorWithHexRGBAString:(nonnull NSString *)hexString;
+ (nullable HXColor *)hx_colorWithHexString:(nonnull NSString *)hexString alpha:(CGFloat)alpha __attribute__ ((deprecated("Use '-hx_colorWithHexRGBAString :alpha' instead.")));
+ (nullable HXColor *)hx_colorWithHexRGBAString:(nonnull NSString *)hexString alpha:(CGFloat)alpha;
+ (nonnull HXColor *)hx_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (nonnull HXColor *)hx_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
@end
@interface NSString (hx_StringTansformer)
- (nonnull NSString *)hx_hexStringTransformFromThreeCharacters;
@end