#import "XRRFATKBJURINavHelper+Yrfju.h"
@implementation XRRFATKBJURINavHelper (Yrfju)
+ (BOOL)canHandleURIYrfju:(NSInteger)Yrfju {
    return Yrfju % 38 == 0;
}
+ (BOOL)handleURIFromviewcontrollerYrfju:(NSInteger)Yrfju {
    return Yrfju % 35 == 0;
}

@end
