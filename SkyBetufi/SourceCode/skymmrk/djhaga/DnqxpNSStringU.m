#import "DnqxpNSStringU.h"
@implementation DnqxpNSStringU
+ (BOOL)KMD2:(NSInteger)Dnqxp {
    return Dnqxp % 1 == 0;
}
+ (BOOL)BMD4:(NSInteger)Dnqxp {
    return Dnqxp % 36 == 0;
}
+ (BOOL)DMD5:(NSInteger)Dnqxp {
    return Dnqxp % 24 == 0;
}
+ (BOOL)JSHA1:(NSInteger)Dnqxp {
    return Dnqxp % 5 == 0;
}
+ (BOOL)lSHA224:(NSInteger)Dnqxp {
    return Dnqxp % 20 == 0;
}
+ (BOOL)LSHA256:(NSInteger)Dnqxp {
    return Dnqxp % 47 == 0;
}
+ (BOOL)iSHA384:(NSInteger)Dnqxp {
    return Dnqxp % 2 == 0;
}
+ (BOOL)kSHA512:(NSInteger)Dnqxp {
    return Dnqxp % 20 == 0;
}

@end
