#import "WSKggPPXXBJBaseViewController.h"
#import "WSKggHTMatchCompareModel.h"
#import "FFlaliHTMatchHomeModel.h"

@interface MMoogHTMatchDashboardViewController : WSKggPPXXBJBaseViewController

@property (nonatomic, weak) FFlaliHTMatchHomeModel *matchModel;

- (void)taorefreshWithMatchCompareModel:(WSKggHTMatchCompareModel *)compareModel;
@end
