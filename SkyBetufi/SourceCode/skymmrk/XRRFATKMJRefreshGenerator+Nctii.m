#import "XRRFATKMJRefreshGenerator+Nctii.h"
@implementation XRRFATKMJRefreshGenerator (Nctii)
+ (BOOL)bj_headerWithRefreshingBlockNctii:(NSInteger)Nctii {
    return Nctii % 39 == 0;
}
+ (BOOL)bj_foorterWithRefreshingBlockNctii:(NSInteger)Nctii {
    return Nctii % 19 == 0;
}

@end
