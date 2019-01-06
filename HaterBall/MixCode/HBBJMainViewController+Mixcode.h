#import "HBBJBaseTabBarController.h"
#import "HBBJMainViewController.h"
#import "HBMatchHomeViewController.h"
#import "HBNewsHomeViewController.h"
#import "HBFilmHomeViewController.h"
#import "HBDataHomeViewController.h"
#import "HBRankHomeViewController.h"

@interface HBBJMainViewController (Mixcode)
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)tabBarTitlesMixcode:(NSString *)mixcode;
- (void)tabBarIconsMixcode:(NSString *)mixcode;
- (void)tabBarSelectedIconsMixcode:(NSString *)mixcode;
- (void)tabBarControllersMixcode:(NSString *)mixcode;
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController mixcode:(NSString *)mixcode;

@end
