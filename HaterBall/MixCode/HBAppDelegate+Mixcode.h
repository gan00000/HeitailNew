#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "HBAppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import <UMPush/UMessage.h>
#import "AFNetworkReachabilityManager.h"
#import "HBBJLaunchViewController.h"
#import "UIView+Toast.h"

@interface HBAppDelegate (Mixcode)
- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions mixcode:(NSString *)mixcode;
- (void)applicationWillResignActive:(UIApplication *)application mixcode:(NSString *)mixcode;
- (void)applicationDidEnterBackground:(UIApplication *)application mixcode:(NSString *)mixcode;
- (void)applicationWillEnterForeground:(UIApplication *)application mixcode:(NSString *)mixcode;
- (void)applicationDidBecomeActive:(UIApplication *)application mixcode:(NSString *)mixcode;
- (void)applicationWillTerminate:(UIApplication *)application mixcode:(NSString *)mixcode;
- (void)sdk_setUpNetworkReachabilityMixcode:(NSString *)mixcode;
- (void)appNetworkChangedNotification:(NSNotification *)notification mixcode:(NSString *)mixcode;
- (void)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation mixcode:(NSString *)mixcode;
- (void)setupPushWithLaunchOptions:(NSDictionary *)launchOptions mixcode:(NSString *)mixcode;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler mixcode:(NSString *)mixcode;
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler mixcode:(NSString *)mixcode;
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler mixcode:(NSString *)mixcode;
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken mixcode:(NSString *)mixcode;

@end
