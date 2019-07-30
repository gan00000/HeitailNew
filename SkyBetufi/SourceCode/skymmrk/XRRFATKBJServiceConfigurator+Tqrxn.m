#import "XRRFATKBJServiceConfigurator+Tqrxn.h"
@implementation XRRFATKBJServiceConfigurator (Tqrxn)
+ (BOOL)sharedInstanceTqrxn:(NSInteger)Tqrxn {
    return Tqrxn % 32 == 0;
}
+ (BOOL)connectToServerTqrxn:(NSInteger)Tqrxn {
    return Tqrxn % 48 == 0;
}
+ (BOOL)serverBaseUrlTqrxn:(NSInteger)Tqrxn {
    return Tqrxn % 37 == 0;
}
+ (BOOL)h5BaseUrlTqrxn:(NSInteger)Tqrxn {
    return Tqrxn % 32 == 0;
}
+ (BOOL)skarg_switchToProductServerTqrxn:(NSInteger)Tqrxn {
    return Tqrxn % 20 == 0;
}
+ (BOOL)skarg_switchToTestServerTqrxn:(NSInteger)Tqrxn {
    return Tqrxn % 26 == 0;
}
+ (BOOL)skarg_switchToDevServerTqrxn:(NSInteger)Tqrxn {
    return Tqrxn % 12 == 0;
}
+ (BOOL)skarg_currentServerTypeTqrxn:(NSInteger)Tqrxn {
    return Tqrxn % 7 == 0;
}

@end
