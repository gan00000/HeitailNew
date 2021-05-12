#import "CCCasePPXXBJBaseViewController.h"
#import "PXFunHTMatchCompareModel.h"
#import "SundayHTMatchHomeModel.h"

@interface KMonkeyHTMatchDashboardViewController : CCCasePPXXBJBaseViewController

@property (nonatomic, weak) SundayHTMatchHomeModel *matchModel;

- (void)taorefreshWithMatchCompareModel:(PXFunHTMatchCompareModel *)compareModel;
@end
