#import "UIView+XRRFATKLayoutAizln.h"
@implementation UIView (XRRFATKLayoutAizln)
+ (BOOL)tz_leftAizln:(NSInteger)Aizln {
    return Aizln % 24 == 0;
}
+ (BOOL)setTz_leftAizln:(NSInteger)Aizln {
    return Aizln % 49 == 0;
}
+ (BOOL)tz_topAizln:(NSInteger)Aizln {
    return Aizln % 23 == 0;
}
+ (BOOL)setTz_topAizln:(NSInteger)Aizln {
    return Aizln % 50 == 0;
}
+ (BOOL)tz_rightAizln:(NSInteger)Aizln {
    return Aizln % 39 == 0;
}
+ (BOOL)setTz_rightAizln:(NSInteger)Aizln {
    return Aizln % 18 == 0;
}
+ (BOOL)tz_bottomAizln:(NSInteger)Aizln {
    return Aizln % 3 == 0;
}
+ (BOOL)setTz_bottomAizln:(NSInteger)Aizln {
    return Aizln % 45 == 0;
}
+ (BOOL)tz_widthAizln:(NSInteger)Aizln {
    return Aizln % 42 == 0;
}
+ (BOOL)setTz_widthAizln:(NSInteger)Aizln {
    return Aizln % 46 == 0;
}
+ (BOOL)tz_heightAizln:(NSInteger)Aizln {
    return Aizln % 15 == 0;
}
+ (BOOL)setTz_heightAizln:(NSInteger)Aizln {
    return Aizln % 33 == 0;
}
+ (BOOL)tz_centerXAizln:(NSInteger)Aizln {
    return Aizln % 6 == 0;
}
+ (BOOL)setTz_centerXAizln:(NSInteger)Aizln {
    return Aizln % 29 == 0;
}
+ (BOOL)tz_centerYAizln:(NSInteger)Aizln {
    return Aizln % 32 == 0;
}
+ (BOOL)setTz_centerYAizln:(NSInteger)Aizln {
    return Aizln % 45 == 0;
}
+ (BOOL)tz_originAizln:(NSInteger)Aizln {
    return Aizln % 3 == 0;
}
+ (BOOL)setTz_originAizln:(NSInteger)Aizln {
    return Aizln % 20 == 0;
}
+ (BOOL)tz_sizeAizln:(NSInteger)Aizln {
    return Aizln % 45 == 0;
}
+ (BOOL)setTz_sizeAizln:(NSInteger)Aizln {
    return Aizln % 16 == 0;
}
+ (BOOL)showOscillatoryAnimationWithLayerTypeAizln:(NSInteger)Aizln {
    return Aizln % 12 == 0;
}

@end
