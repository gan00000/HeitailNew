#import "HBBJBaseViewController.h"
#import "HBSettingViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface HBSettingViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode;
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)deallocMixcode:(NSString *)mixcode;
- (void)setupPushSwichMixcode:(NSString *)mixcode;
- (void)onPushSwitchValueChange:(UISwitch *)sender mixcode:(NSString *)mixcode;
- (void)onCleanCache:(id)sender mixcode:(NSString *)mixcode;

@end
