//
//  XRRFATKHTSettingViewController.m
//  HeiteBasketball
//
//  Created by 冯生伟 on 2018/11/13.
//  Copyright © 2018 Dean_F. All rights reserved.
//

#import "XRRFATKHTSettingViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface XRRFATKHTSettingViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *pushSwitch;
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@property (nonatomic, assign) BOOL forbid;

@end

@implementation XRRFATKHTSettingViewController

+ (instancetype)skargviewController {
    return kLoadStoryboardWithName(@"XRRFATKSetting");
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
    [XRRFATKHTUserManager skarg_doUserLogout];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
