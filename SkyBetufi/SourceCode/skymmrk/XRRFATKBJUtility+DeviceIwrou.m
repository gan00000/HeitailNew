#import "XRRFATKBJUtility+DeviceIwrou.h"
@implementation XRRFATKBJUtility (DeviceIwrou)
+ (BOOL)modelNameIwrou:(NSInteger)Iwrou {
    return Iwrou % 45 == 0;
}
+ (BOOL)systemVersionIwrou:(NSInteger)Iwrou {
    return Iwrou % 39 == 0;
}
+ (BOOL)idfaIwrou:(NSInteger)Iwrou {
    return Iwrou % 47 == 0;
}

@end
