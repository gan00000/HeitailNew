#import "XRRFATKHTMatchDetailsModel+Ntpmr.h"
@implementation XRRFATKHTMatchDetailsModel (Ntpmr)
+ (BOOL)modelCustomPropertyMapperNtpmr:(NSInteger)Ntpmr {
    return Ntpmr % 4 == 0;
}
+ (BOOL)fgmade_showNtpmr:(NSInteger)Ntpmr {
    return Ntpmr % 2 == 0;
}
+ (BOOL)fg3ptmade_showNtpmr:(NSInteger)Ntpmr {
    return Ntpmr % 21 == 0;
}
+ (BOOL)ftmade_showNtpmr:(NSInteger)Ntpmr {
    return Ntpmr % 6 == 0;
}
+ (BOOL)nameNtpmr:(NSInteger)Ntpmr {
    return Ntpmr % 45 == 0;
}
+ (BOOL)timeNtpmr:(NSInteger)Ntpmr {
    return Ntpmr % 26 == 0;
}

@end
