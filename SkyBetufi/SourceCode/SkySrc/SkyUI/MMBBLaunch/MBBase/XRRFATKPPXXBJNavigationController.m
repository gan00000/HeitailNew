#import "XRRFATKPPXXBJNavigationController.h"
#import "XRRFATKHTMatchHomeViewController.h"
#import "XRRFATKHTNewsHomeViewController.h"
#import "XRRFATKHTFilmHomeViewController.h"
#import "XRRFATKHTDataHomeViewController.h"
#import "XRRFATKHTRankHomeViewController.h"
#import "XRRFATKHTTabBarHomeViewController.h"
#import "XRRFATKHTNewsHomeOtherViewController.h"
@interface XRRFATKPPXXBJNavigationController ()
@end
@implementation XRRFATKPPXXBJNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-64)
                                                         forBarMetrics:UIBarMetricsDefault];
    NSDictionary *barItemAttris = @{ NSFontAttributeName : [UIFont systemFontOfSize:15 weight:UIFontWeightLight] };
    [[UIBarButtonItem appearance] setTitleTextAttributes:barItemAttris forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    UIFont *font = [UIFont systemFontOfSize:18];
    NSShadow *shadow = [[NSShadow alloc] init];
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSShadowAttributeName : shadow,
                                  NSFontAttributeName : font };
    [self.navigationBar setTitleTextAttributes:attributes];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSArray<Class> *)skargviewControllersNotHideTabBar {
    return @[[XRRFATKHTMatchHomeViewController class],
             [XRRFATKHTNewsHomeViewController class],
             [XRRFATKHTFilmHomeViewController class],
             [XRRFATKHTDataHomeViewController class],
             [XRRFATKHTRankHomeViewController class],
             [XRRFATKHTNewsHomeOtherViewController class],
             [XRRFATKHTTabBarHomeViewController class]];
}
@end
