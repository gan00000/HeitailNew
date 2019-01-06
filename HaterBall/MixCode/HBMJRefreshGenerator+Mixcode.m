#import "HBMJRefreshGenerator+Mixcode.h"
@implementation HBMJRefreshGenerator (Mixcode)
+ (void)bj_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)bj_foorterWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
