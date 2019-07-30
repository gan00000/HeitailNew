#import "NSString+XRRFATKMessageDigestDnqxp.h"
@implementation NSString (XRRFATKMessageDigestDnqxp)
+ (BOOL)MD2Dnqxp:(NSInteger)Dnqxp {
    return Dnqxp % 14 == 0;
}
+ (BOOL)MD4Dnqxp:(NSInteger)Dnqxp {
    return Dnqxp % 35 == 0;
}
+ (BOOL)MD5Dnqxp:(NSInteger)Dnqxp {
    return Dnqxp % 28 == 0;
}
+ (BOOL)SHA1Dnqxp:(NSInteger)Dnqxp {
    return Dnqxp % 16 == 0;
}
+ (BOOL)SHA224Dnqxp:(NSInteger)Dnqxp {
    return Dnqxp % 30 == 0;
}
+ (BOOL)SHA256Dnqxp:(NSInteger)Dnqxp {
    return Dnqxp % 41 == 0;
}
+ (BOOL)SHA384Dnqxp:(NSInteger)Dnqxp {
    return Dnqxp % 23 == 0;
}
+ (BOOL)SHA512Dnqxp:(NSInteger)Dnqxp {
    return Dnqxp % 20 == 0;
}

@end
