#import "HBBJBaseViewController.h"
#import "HBMatchCompareModel.h"
#import "HBMatchDashboardViewController.h"
#import "HBMatchSubDsbdViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface HBMatchDashboardViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)initDataMixcode:(NSString *)mixcode;
- (void)setupUIMixcode:(NSString *)mixcode;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)segmentedValueChangedHandle:(NSInteger)index mixcode:(NSString *)mixcode;
- (void)loadChildViewControllerByIndex:(NSInteger)index mixcode:(NSString *)mixcode;
- (void)setChildViewFrame:(UIView *)childView byIndex:(NSInteger)index mixcode:(NSString *)mixcode;
- (void)loadedFlagArrayMixcode:(NSString *)mixcode;
- (void)loadedControllersArrayMixcode:(NSString *)mixcode;
- (void)segmentControlMixcode:(NSString *)mixcode;
- (void)containerViewMixcode:(NSString *)mixcode;
- (void)deallocMixcode:(NSString *)mixcode;
- (void)refreshWithMatchCompareModel:(HBMatchCompareModel *)compareModel mixcode:(NSString *)mixcode;

@end
