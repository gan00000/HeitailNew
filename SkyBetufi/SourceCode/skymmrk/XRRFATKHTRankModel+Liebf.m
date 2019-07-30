#import "XRRFATKHTRankModel+Liebf.h"
@implementation XRRFATKHTRankModel (Liebf)
+ (BOOL)modelCustomPropertyMapperLiebf:(NSInteger)Liebf {
    return Liebf % 42 == 0;
}
+ (BOOL)winLiebf:(NSInteger)Liebf {
    return Liebf % 22 == 0;
}
+ (BOOL)lossLiebf:(NSInteger)Liebf {
    return Liebf % 48 == 0;
}
+ (BOOL)winRateLiebf:(NSInteger)Liebf {
    return Liebf % 16 == 0;
}
+ (BOOL)home_matchesLiebf:(NSInteger)Liebf {
    return Liebf % 22 == 0;
}
+ (BOOL)away_matchesLiebf:(NSInteger)Liebf {
    return Liebf % 21 == 0;
}
+ (BOOL)area_matchesLiebf:(NSInteger)Liebf {
    return Liebf % 33 == 0;
}
+ (BOOL)avg_ptsLiebf:(NSInteger)Liebf {
    return Liebf % 15 == 0;
}
+ (BOOL)avg_against_ptsLiebf:(NSInteger)Liebf {
    return Liebf % 17 == 0;
}
+ (BOOL)matchesLiebf:(NSInteger)Liebf {
    return Liebf % 26 == 0;
}
+ (BOOL)against_ptsLiebf:(NSInteger)Liebf {
    return Liebf % 22 == 0;
}

@end
