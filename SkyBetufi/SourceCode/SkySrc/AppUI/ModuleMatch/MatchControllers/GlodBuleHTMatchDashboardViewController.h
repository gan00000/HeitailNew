#import "GlodBulePPXXBJBaseViewController.h"
#import "GlodBuleHTMatchCompareModel.h"
#import "GlodBuleHTMatchHomeModel.h"

@interface GlodBuleHTMatchDashboardViewController : GlodBulePPXXBJBaseViewController

@property (nonatomic, weak) GlodBuleHTMatchHomeModel *matchModel;

- (void)taorefreshWithMatchCompareModel:(GlodBuleHTMatchCompareModel *)compareModel;
@end
