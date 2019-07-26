//
//  AppDelegate.h
//  BenjiaPro
//
//  Created by Marco on 2017/5/22.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSDictionary *pushInfo;

- (void)responsePushInfo:(NSDictionary *)pushInfo fromViewController:(UIViewController *)vc;

@end

