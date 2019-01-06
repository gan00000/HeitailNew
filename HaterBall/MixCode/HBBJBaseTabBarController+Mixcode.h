#import <UIKit/UIKit.h>
#import "HBBJBaseTabBarController.h"

@interface HBBJBaseTabBarController (Mixcode)
- (void)viewDidLoadMixcode:(NSString *)mixcode;
- (void)shouldAutorotateMixcode:(NSString *)mixcode;
- (void)tabBarIconsMixcode:(NSString *)mixcode;
- (void)tabBarSelectedIconsMixcode:(NSString *)mixcode;
- (void)tabBarTitlesMixcode:(NSString *)mixcode;
- (void)tabBarControllersMixcode:(NSString *)mixcode;

@end
