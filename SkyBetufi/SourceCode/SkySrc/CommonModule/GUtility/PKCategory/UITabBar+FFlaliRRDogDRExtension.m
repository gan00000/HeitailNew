#import "UITabBar+FFlaliRRDogDRExtension.h"
@implementation UITabBar (RRDogDRExtension)
+ (CGFloat)tabBarHeight {
    if ([UINavigationBar isIphoneXSeries]) {
        return 49.0 + [self iPhoneXTabarSafeHeight];
    }
    return 49.0;
}
+ (CGFloat)safeHeight {
    if ([UINavigationBar isIphoneXSeries]) {
        return 34.0;
    }
    return 0.0;
}
+ (CGFloat)iPhoneXTabarSafeHeight {
    return 34;
}
- (CGFloat)tabBarHeight {
    return [UITabBar tabBarHeight];
}
@end
