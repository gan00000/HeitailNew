//
//  AppDelegate.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/22.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMPush/UMessage.h>
#import <LineSDK/LineSDK.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AFNetworkReachabilityManager.h"
#import "XRRFATKPPXXBJLaunchViewController.h"
#import "UIView+XRRFATKToast.h"
#import "XRRFATKHTNewsDetailViewController.h"

#define UM_APP_KEY @"5bd67116f1f556f834000081"
#define FB_APP_ID  @"479868032525276"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UMConfigure initWithAppkey:UM_APP_KEY channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];
    
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook
                                          appKey:FB_APP_ID
                                       appSecret:nil
                                     redirectURL:@"http://www.ballgametime.com"];
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_FaceBookMessenger]) {
        [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_FaceBookMessenger];
    }
    if (![[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Facebook]) {
        [[UMSocialManager defaultManager] removePlatformProviderWithPlatformType:UMSocialPlatformType_Facebook];
    }    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Line
                                          appKey:nil appSecret:nil
                                     redirectURL:@"http://www.ballgametime.com"];
    
    [self sdk_setUpNetworkReachability];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    XRRFATKPPXXBJLaunchViewController *rootVc = [[XRRFATKPPXXBJLaunchViewController alloc] init];
    self.window.rootViewController = rootVc;
    
    [self setupPushWithLaunchOptions:launchOptions];
    
    [IQKeyboardManager sharedManager].toolbarBarTintColor = [UIColor whiteColor];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    self.pushInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (self.pushInfo) {
        [UMessage didReceiveRemoteNotification:self.pushInfo];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AFNetworkingReachabilityDidChangeNotification
                                                  object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appNetworkChangedNotification:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - SDK init
- (void)sdk_setUpNetworkReachability {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appNetworkChangedNotification:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
}

#pragma mark - Notifications
- (void)appNetworkChangedNotification:(NSNotification *)notification {
    AFNetworkReachabilityStatus status = [notification.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
    if (status == AFNetworkReachabilityStatusNotReachable) {
        [self.window showToast:@"未连接到网络！" duration:3];
    }
}

#pragma mark - share
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[FBSDKApplicationDelegate sharedInstance] application:app
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    if (!result) {
        result = [[LineSDKLogin sharedInstance] handleOpenURL:url];
    }
    if (!result) {
        result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    }
    return result;
}

#pragma mark - push
- (void)setupPushWithLaunchOptions:(NSDictionary *)launchOptions {
    // Push功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    if (@available(iOS 10.0, *)) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories = categories;
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    } else if (@available(iOS 8.0, *)) {
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title = @"打开应用";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title = @"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";//这组动作的唯一标示
        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
        entity.categories = categories;
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
        } else {
            
        }
    }];
}

//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
//    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
      willPresentNotification:(UNNotification *)notification
        withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    } else {
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
        withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        [self responsePushInfo:userInfo fromViewController:nil]; // 前台或者后台点击响应
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *pushDeviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                                 stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (pushDeviceToken.length) {
        BJLog(@"deviceToken: %@", pushDeviceToken);
        [XRRFATKHTUserManager skarg_saveDeviceToken:pushDeviceToken];
    }
}

- (void)responsePushInfo:(NSDictionary *)pushInfo fromViewController:(UIViewController *)vc {
    if (!pushInfo) {
        return;
    }
    
    if (!vc) {
        vc = [XRRFATKPPXXBJViewControllerCenter currentViewController];
    }
    
    XRRFATKHTNewsDetailViewController *detailVc = [XRRFATKHTNewsDetailViewController skargviewController];
    detailVc.post_id = pushInfo[@"postId"];
    
    if (vc.navigationController) {
        [vc.navigationController pushViewController:detailVc animated:YES];
    } else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVc];
        [vc presentViewController:nav animated:YES completion:nil];
    }
}

@end
