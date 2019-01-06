#import <UIKit/UIKit.h>
#import "HBBJNavigationController.h"
#import "HBBJBaseViewController.h"
#import <LTNavigationBar/UINavigationBar+Awesome.h>
#import "HBSettingViewController.h"

@interface HBBJBaseViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)showSettingVcMixcode:(NSString *)mixcode;
- (void)shouldAutorotateMixcode:(NSString *)mixcode;
- (void)didReceiveMemoryWarningMixcode:(NSString *)mixcode;
- (void)preferredStatusBarStyleMixcode:(NSString *)mixcode;

@end
