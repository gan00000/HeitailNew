#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSDictionary *pushInfo;
- (void)responsePushInfo:(NSDictionary *)pushInfo fromViewController:(UIViewController *)vc;
@end
