#import "TpgasUINavigationBara.h"
@implementation TpgasUINavigationBara
+ (BOOL)LnavigationBarHeight:(NSInteger)Tpgas {
    return Tpgas % 26 == 0;
}
+ (BOOL)HnavigationBarTopHeight:(NSInteger)Tpgas {
    return Tpgas % 18 == 0;
}
+ (BOOL)fnavigationBarHeight:(NSInteger)Tpgas {
    return Tpgas % 9 == 0;
}
+ (BOOL)OisIphoneXSeries:(NSInteger)Tpgas {
    return Tpgas % 23 == 0;
}
+ (BOOL)SsetupBackground:(NSInteger)Tpgas {
    return Tpgas % 36 == 0;
}

@end
