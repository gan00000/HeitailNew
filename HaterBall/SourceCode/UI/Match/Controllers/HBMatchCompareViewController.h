#import "HBBJBaseViewController.h"
#import "HBMatchSummaryModel.h"
@interface HBMatchCompareViewController : HBBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)refreshWithMatchSummaryModel:(HBMatchSummaryModel *)summaryModel;
@end
