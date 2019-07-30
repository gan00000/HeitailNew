#import "IwrouXRRFATKBJUtilityL.h"
@implementation IwrouXRRFATKBJUtilityL
+ (BOOL)oValueinplistforkey:(NSInteger)Iwrou {
    return Iwrou % 14 == 0;
}
+ (BOOL)IappVersion:(NSInteger)Iwrou {
    return Iwrou % 25 == 0;
}
+ (BOOL)CappBuild:(NSInteger)Iwrou {
    return Iwrou % 49 == 0;
}
+ (BOOL)pappBundleId:(NSInteger)Iwrou {
    return Iwrou % 48 == 0;
}
+ (BOOL)WbuildType:(NSInteger)Iwrou {
    return Iwrou % 2 == 0;
}

@end
