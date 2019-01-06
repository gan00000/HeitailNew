#import "HBBJBaseViewController.h"
#import "HBRankHomeViewController.h"
#import "HBRankEastWestViewController.h"
#import "HBRankZoneViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface HBRankHomeViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
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

@end
