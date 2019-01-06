#import "HBBJBaseViewController.h"
#import "HBMatchHomeModel.h"
#import "HBMatchDetailViewController.h"
#import "HBMatchWordLiveViewController.h"
#import "HBMatchCompareViewController.h"
#import "HBMatchDashboardViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import <WebKit/WebKit.h>
#import "HBMatchLiveFeedRequest.h"
#import "HBMatchSummaryRequest.h"

@interface HBMatchDetailViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)viewWillDisappear:(BOOL)animated mixcode:(NSString *)mixcode;
- (void)deallocMixcode:(NSString *)mixcode;
- (void)setupUIMixcode:(NSString *)mixcode;
- (void)initDataMixcode:(NSString *)mixcode;
- (void)loadDataMixcode:(NSString *)mixcode;
- (void)refreshUIMixcode:(NSString *)mixcode;
- (void)startTimerMixcode:(NSString *)mixcode;
- (void)stopTimerMixcode:(NSString *)mixcode;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView mixcode:(NSString *)mixcode;
- (void)segmentedValueChangedHandle:(NSInteger)index mixcode:(NSString *)mixcode;
- (void)loadChildViewControllerByIndex:(NSInteger)index mixcode:(NSString *)mixcode;
- (void)setChildViewFrame:(UIView *)childView byIndex:(NSInteger)index mixcode:(NSString *)mixcode;
- (void)loadedFlagArrayMixcode:(NSString *)mixcode;
- (void)loadedControllersArrayMixcode:(NSString *)mixcode;
- (void)segmentControlMixcode:(NSString *)mixcode;
- (void)containerViewMixcode:(NSString *)mixcode;
- (void)homeTeamLogoWebMixcode:(NSString *)mixcode;
- (void)awayTeamLogoWebMixcode:(NSString *)mixcode;

@end
