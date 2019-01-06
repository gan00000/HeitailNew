#import "HBSettingViewController+Mixcode.h"
@implementation HBSettingViewController (Mixcode)
+ (void)viewControllerMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)viewDidLoadMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)deallocMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)setupPushSwichMixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)onPushSwitchValueChange:(UISwitch *)sender mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
- (void)onCleanCache:(id)sender mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
