#import "XRRFATKPPXXBJBaseViewController.h"
#import "XRRFATKHTMatchSummaryModel.h"
@interface XRRFATKHTMatchCompareViewController : XRRFATKPPXXBJBaseViewController
@property (nonatomic, copy) void (^onTableHeaderRefreshBlock)(void);
- (void)skargrefreshWithMatchSummaryModel:(XRRFATKHTMatchSummaryModel *)summaryModel;
@end
