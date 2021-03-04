#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
@import Firebase;
@import GoogleSignIn;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate, GIDSignInDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSDictionary *pushInfo;
- (void)responsePushInfo:(NSDictionary *)pushInfo fromViewController:(UIViewController *)vc;
@end
