#import <Foundation/Foundation.h>
#import "MJRefresh.h"
#import "HBMJRefreshGenerator.h"

@interface HBMJRefreshGenerator (Mixcode)
+ (void)bj_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock mixcode:(NSString *)mixcode;
+ (void)bj_foorterWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock mixcode:(NSString *)mixcode;

@end
