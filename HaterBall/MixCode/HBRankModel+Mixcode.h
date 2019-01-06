#import <Foundation/Foundation.h>
#import "HBRankModel.h"

@interface HBRankModel (Mixcode)
+ (void)modelCustomPropertyMapperMixcode:(NSString *)mixcode;
- (void)winMixcode:(NSString *)mixcode;
- (void)lossMixcode:(NSString *)mixcode;
- (void)winRateMixcode:(NSString *)mixcode;
- (void)home_matchesMixcode:(NSString *)mixcode;
- (void)away_matchesMixcode:(NSString *)mixcode;
- (void)area_matchesMixcode:(NSString *)mixcode;
- (void)avg_ptsMixcode:(NSString *)mixcode;
- (void)avg_against_ptsMixcode:(NSString *)mixcode;
- (void)matchesMixcode:(NSString *)mixcode;
- (void)against_ptsMixcode:(NSString *)mixcode;

@end
