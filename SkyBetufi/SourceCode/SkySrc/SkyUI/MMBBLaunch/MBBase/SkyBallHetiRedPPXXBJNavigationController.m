#import "SkyBallHetiRedPPXXBJNavigationController.h"
#import "SkyBallHetiRedHTMatchHomeViewController.h"
#import "SkyBallHetiRedHTNewsHomeViewController.h"
#import "SkyBallHetiRedHTFilmHomeViewController.h"
#import "SkyBallHetiRedHTDataHomeViewController.h"
#import "SkyBallHetiRedHTRankHomeViewController.h"
#import "SkyBallHetiRedHTTabBarHomeViewController.h"
#import "SkyBallHetiRedHTNewsHomeOtherViewController.h"
#import "SkyBallHetiRedPPXXBJLaunchViewController.h"
@interface SkyBallHetiRedPPXXBJNavigationController ()
@end
@implementation SkyBallHetiRedPPXXBJNavigationController
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
- (NSArray<Class> *)waterSkyviewControllersNotHideTabBar {
    return @[[SkyBallHetiRedHTMatchHomeViewController class],
             [SkyBallHetiRedHTNewsHomeViewController class],
             [SkyBallHetiRedHTFilmHomeViewController class],
             [SkyBallHetiRedHTDataHomeViewController class],
             [SkyBallHetiRedHTRankHomeViewController class],
             [SkyBallHetiRedHTNewsHomeOtherViewController class],
             [SkyBallHetiRedPPXXBJLaunchViewController class],
             [SkyBallHetiRedHTTabBarHomeViewController class]];
}
@end
