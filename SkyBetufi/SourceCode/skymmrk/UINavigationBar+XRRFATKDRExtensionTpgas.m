#import "UINavigationBar+XRRFATKDRExtensionTpgas.h"
@implementation UINavigationBar (XRRFATKDRExtensionTpgas)
+ (BOOL)navigationBarHeightTpgas:(NSInteger)Tpgas {
    return Tpgas % 25 == 0;
}
+ (BOOL)navigationBarTopHeightTpgas:(NSInteger)Tpgas {
    return Tpgas % 37 == 0;
}

+ (BOOL)isIphoneXSeriesTpgas:(NSInteger)Tpgas {
    return Tpgas % 48 == 0;
}
+ (BOOL)setupBackgroundTpgas:(NSInteger)Tpgas {
    return Tpgas % 10 == 0;
}

@end
