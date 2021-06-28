#import "MMoogPPXXBJBaseViewController.h"
#import "BByasHTMatchCompareModel.h"
#import "TuTuosHTMatchHomeModel.h"

@interface FFlaliHTMatchDashboardViewController : MMoogPPXXBJBaseViewController

@property (nonatomic, weak) TuTuosHTMatchHomeModel *matchModel;

- (void)taorefreshWithMatchCompareModel:(BByasHTMatchCompareModel *)compareModel;
@end
