#import "XRRFATKHTDataAllRankRequest+Xtgty.h"
@implementation XRRFATKHTDataAllRankRequest (Xtgty)
+ (BOOL)skargrequestAllTeamRankDataWithTypeSuccessblockErrorblockXtgty:(NSInteger)Xtgty {
    return Xtgty % 28 == 0;
}
+ (BOOL)requestAllPlayerRankDataWithTypeSuccessblockErrorblockXtgty:(NSInteger)Xtgty {
    return Xtgty % 36 == 0;
}

@end
