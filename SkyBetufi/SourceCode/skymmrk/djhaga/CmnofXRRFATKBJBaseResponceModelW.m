#import "CmnofXRRFATKBJBaseResponceModelW.h"
@implementation CmnofXRRFATKBJBaseResponceModelW
+ (BOOL)GskargpagesValueOfPage:(NSInteger)Cmnof {
    return Cmnof % 10 == 0;
}
+ (BOOL)gskargtotalValueOfPage:(NSInteger)Cmnof {
    return Cmnof % 23 == 0;
}

@end
