#import "HBBJNavigationController.h"
#import "HBMatchHomeViewController.h"
#import "HBNewsHomeViewController.h"
#import "HBFilmHomeViewController.h"
#import "HBDataHomeViewController.h"
#import "HBRankHomeViewController.h"
@interface HBBJNavigationController ()
@end
@implementation HBBJNavigationController
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
- (NSArray<Class> *)viewControllersNotHideTabBar {
    return @[[HBMatchHomeViewController class],
             [HBNewsHomeViewController class],
             [HBFilmHomeViewController class],
             [HBDataHomeViewController class],
             [HBRankHomeViewController class]];
}
@end
