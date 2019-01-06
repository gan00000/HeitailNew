#import "HBBJBaseViewController.h"
#import "HBBJLaunchViewController.h"
#import "HBBJMainViewController.h"
#import "HBAppDelegate.h"

@interface HBBJLaunchViewController (Mixcode)
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag mixcode:(NSString *)mixcode;
- (void)tabBarControllerMixcode:(NSString *)mixcode;

@end
