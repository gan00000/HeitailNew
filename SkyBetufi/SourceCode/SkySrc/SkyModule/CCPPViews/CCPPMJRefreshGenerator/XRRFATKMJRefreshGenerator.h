#import <Foundation/Foundation.h>
#import "MJRefresh.h"
@interface XRRFATKMJRefreshGenerator : NSObject
+ (MJRefreshStateHeader *)bj_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
+ (MJRefreshBackStateFooter *)bj_foorterWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
@end
