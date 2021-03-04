#import "GlodBuleHTSettingViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface GlodBuleHTSettingViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *pushSwitch;
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (nonatomic, assign) BOOL forbid;
@end
@implementation GlodBuleHTSettingViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(@"SkyBallHetiRedSetting");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"設置";
    self.cacheLabel.text = [NSString stringWithFormat:@"%.2fM", [SDImageCache sharedImageCache].getSize / 1024.0 / 1024.0];
    [self setupPushSwich];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupPushSwich) name:UIApplicationWillEnterForegroundNotification object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupPushSwich {
    kWeakSelf
    if (@available(iOS 10 , *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                    weakSelf.pushSwitch.on = YES;
                } else {
                    weakSelf.pushSwitch.on = NO;
                }
            });
        }];
    } else if (@available(iOS 8 , *)) {
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (setting.types != UIUserNotificationTypeNone) {
            weakSelf.pushSwitch.on = YES;
        } else {
            weakSelf.pushSwitch.on = NO;
        }
    }
}
- (IBAction)onPushSwitchValueChange:(UISwitch *)sender {
    NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:appSettings];
}
- (IBAction)onCleanCache:(id)sender {
    kWeakSelf
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [weakSelf.view showToast:@"已清除！"];
        weakSelf.cacheLabel.text = @"0.00M";
    }];
}
- (IBAction)logoutAction:(id)sender {
    [GlodBuleHTUserManager tao_doUserLogout];
    //[self dismissViewControllerAnimated:YES completion:nil];
    [kWindow showToast:@"退出成功"];
}
@end
