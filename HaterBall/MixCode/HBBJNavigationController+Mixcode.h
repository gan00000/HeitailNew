#import "HBBJBaseNavigationController.h"
#import "HBBJNavigationController.h"
#import "HBMatchHomeViewController.h"
#import "HBNewsHomeViewController.h"
#import "HBFilmHomeViewController.h"
#import "HBDataHomeViewController.h"
#import "HBRankHomeViewController.h"

@interface HBBJNavigationController (Mixcode)
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)viewControllersNotHideTabBarMixcode:(NSString *)mixcode;

@end
