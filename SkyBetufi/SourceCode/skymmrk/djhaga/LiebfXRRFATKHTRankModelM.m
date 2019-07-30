#import "LiebfXRRFATKHTRankModelM.h"
@implementation LiebfXRRFATKHTRankModelM
+ (BOOL)cmodelCustomPropertyMapper:(NSInteger)Liebf {
    return Liebf % 49 == 0;
}
+ (BOOL)Rwin:(NSInteger)Liebf {
    return Liebf % 43 == 0;
}
+ (BOOL)Dloss:(NSInteger)Liebf {
    return Liebf % 1 == 0;
}
+ (BOOL)fwinRate:(NSInteger)Liebf {
    return Liebf % 36 == 0;
}
+ (BOOL)uhome_matches:(NSInteger)Liebf {
    return Liebf % 11 == 0;
}
+ (BOOL)Haway_matches:(NSInteger)Liebf {
    return Liebf % 43 == 0;
}
+ (BOOL)Harea_matches:(NSInteger)Liebf {
    return Liebf % 30 == 0;
}
+ (BOOL)navg_pts:(NSInteger)Liebf {
    return Liebf % 43 == 0;
}
+ (BOOL)mavg_against_pts:(NSInteger)Liebf {
    return Liebf % 34 == 0;
}
+ (BOOL)rmatches:(NSInteger)Liebf {
    return Liebf % 48 == 0;
}
+ (BOOL)Dagainst_pts:(NSInteger)Liebf {
    return Liebf % 25 == 0;
}

@end
