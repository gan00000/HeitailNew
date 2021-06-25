#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMPush/UMessage.h>
#import <LineSDK/LineSDK.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AFNetworkReachabilityManager.h"
#import "FFlaliPPXXBJLaunchViewController.h"
#import "UIView+BByasRRDogToast.h"
#import "NSNiceHTNewsDetailViewController.h"
#import "YeYeePPXXBJNavigationController.h"
#import "BlysaHTNewsHomeViewController.h"
#import "BlysaPPXXBJMainViewController.h"
@import Firebase;
@import GoogleMobileAds;
#import "NSNiceHTUserManager.h"

#define UM_APP_KEY @"60d3569126a57f101836a71a"
#define FB_APP_ID  @"393368845385476"
@implementation AppDelegate
- (void)openViewController:(UIApplication * _Nonnull)application launchOptions:(NSDictionary * _Nullable)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    FFlaliPPXXBJLaunchViewController *rootVc = [[FFlaliPPXXBJLaunchViewController alloc] init];
//    self.window.rootViewController = rootVc;

    
    self.window.rootViewController = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:rootVc];
    
//     self.window.rootViewController = [[BlysaPPXXBJMainViewController alloc] init];
    
    [self setupPushWithLaunchOptions:launchOptions];
    [IQKeyboardManager sharedManager].toolbarBarTintColor = [UIColor whiteColor];
//    [IQKeyboardManager sharedManager].enable = NO;
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    self.pushInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (self.pushInfo) {
        [UMessage didReceiveRemoteNotification:self.pushInfo];
    }
    
    //admob初始化
    [[GADMobileAds sharedInstance] startWithCompletionHandler:^(GADInitializationStatus * _Nonnull status) {
        NSLog(@"startWithCompletionHandler finish");
    }];
}

- (void)setUpUM {
    
     [UMConfigure setEncryptEnabled:YES];//打开加密传输
     [UMConfigure setLogEnabled:YES];//设置打开日志
//     [UMConfigure setLogEnabled:YES];
    [UMConfigure initWithAppkey:UM_APP_KEY channel:@"App Store"];
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
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    // Use Firebase library to configure APIs
    [FIRApp configure];
    //GIDSignIn
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
    
    [self setUpUM];
    [self sdk_setUpNetworkReachability];
    [self openViewController:application launchOptions:launchOptions];
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
#pragma mark - share
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[FBSDKApplicationDelegate sharedInstance] application:app
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    if (!result) {
        result = [[GIDSignIn sharedInstance] handleURL:url];
    }
    
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
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
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
        action1.activationMode = UIUserNotificationActivationModeForeground;
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  
        action2.identifier = @"action2_identifier";
        action2.title = @"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;
        action2.authenticationRequired = YES;
        action2.destructive = YES;
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";
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
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
//    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *pushDeviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                                 stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (pushDeviceToken.length) {
        BJLog(@"deviceToken: %@", pushDeviceToken);
        [NSNiceHTUserManager tao_saveDeviceToken:pushDeviceToken];
    }
}
- (void)responsePushInfo:(NSDictionary *)pushInfo fromViewController:(UIViewController *)vc {
    if (!pushInfo) {
        return;
    }
    if (!vc) {
        vc = [UUaksPPXXBJViewControllerCenter currentViewController];
    }
    NSNiceHTNewsDetailViewController *detailVc = [NSNiceHTNewsDetailViewController taoviewController];
    detailVc.post_id = pushInfo[@"postId"];
    if (vc.navigationController) {
        [vc.navigationController pushViewController:detailVc animated:YES];
    } else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVc];
        [vc presentViewController:nav animated:YES completion:nil];
    }
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
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
      willPresentNotification:(UNNotification *)notification
        withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
    } else {
    }
    completionHandler(UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionAlert);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
        withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage didReceiveRemoteNotification:userInfo];
        [self responsePushInfo:userInfo fromViewController:nil]; 
    }else{
    }
}


#pragma mark - GIDSignIn
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
  // ...
  if (error == nil) {
    GIDAuthentication *authentication = user.authentication;
//    FIRAuthCredential *credential =
//    [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken accessToken:authentication.accessToken];
      NSString *idToken = authentication.idToken;
      NSString *userId = user.userID;
      NSString *name = user.profile.name;
      NSString *email = user.profile.email;
      
      [[NSNiceHTUserManager manager] doThirdLoginRequesWithAccessToken:idToken sns:4 userId:userId nickName:name email:email];
    // ...
  } else {
    // ...
      NSLog(@"GIDSignIn didDisconnectWithUser:%@",error.localizedDescription);
  }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
  // Perform any operations when the user disconnects from app here.
  // ...
    NSLog(@"GIDSignIn didDisconnectWithUser:%@",error.localizedDescription);
}
@end
