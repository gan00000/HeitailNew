#import "HBAppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMPush/UMessage.h>
#import "AFNetworkReachabilityManager.h"
#import "HBBJLaunchViewController.h"
#import "UIView+Toast.h"
#define UM_APP_KEY @"5bd67116f1f556f834000081"
#define FB_APP_ID  @"479868032525276"
@implementation HBAppDelegate
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
    if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Line]) {
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Line
                                              appKey:nil appSecret:nil
                                         redirectURL:@"http://www.ballgametime.com"];
    }
    [self sdk_setUpNetworkReachability];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    HBBJLaunchViewController *rootVc = [[HBBJLaunchViewController alloc] init];
    self.window.rootViewController = rootVc;
    [self setupPushWithLaunchOptions:launchOptions];
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
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
    }
    return result;
}
#pragma mark - push
- (void)setupPushWithLaunchOptions:(NSDictionary *)launchOptions {
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"打开应用";
        action1.activationMode = UIUserNotificationActivationModeForeground;
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  
        action2.identifier = @"action2_identifier";
        action2.title=@"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;
        action2.authenticationRequired = YES;
        action2.destructive = YES;
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";
        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
        entity.categories=categories;
    }
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
    }
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
    }
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *pushDeviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                                 stringByReplacingOccurrencesOfString:@" " withString:@""];
    BJLog(@"Device Token = %@", pushDeviceToken);
}
@end
