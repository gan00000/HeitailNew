#import "HBMJRefreshGenerator.h"
@implementation HBMJRefreshGenerator
+ (MJRefreshStateHeader *)bj_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefreshStateHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"釋放更新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在更新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"加載完成" forState:MJRefreshStateNoMoreData];
    header.lastUpdatedTimeLabel.hidden = YES;
    return header;
}
+ (MJRefreshBackStateFooter *)bj_foorterWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshBackStateFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:refreshingBlock];
    [footer setTitle:@"上拉加載更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"釋放加載" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加載" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"暫無更多數據" forState:MJRefreshStateNoMoreData];
    return footer;
}
@end
