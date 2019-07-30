#import "MjvktUITabBary.h"
@implementation MjvktUITabBary
+ (BOOL)mtabBarHeight:(NSInteger)Mjvkt {
    return Mjvkt % 19 == 0;
}
+ (BOOL)csafeHeight:(NSInteger)Mjvkt {
    return Mjvkt % 14 == 0;
}
+ (BOOL)viPhoneXTabarSafeHeight:(NSInteger)Mjvkt {
    return Mjvkt % 26 == 0;
}
+ (BOOL)jtabBarHeight:(NSInteger)Mjvkt {
    return Mjvkt % 32 == 0;
}

@end
