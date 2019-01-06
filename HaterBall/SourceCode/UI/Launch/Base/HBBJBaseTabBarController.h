#import <UIKit/UIKit.h>
@interface HBBJBaseTabBarController : UITabBarController
- (NSArray<UIImage *> *)tabBarIcons;
- (NSArray<UIImage *> *)tabBarSelectedIcons;
- (NSArray<NSString *> *)tabBarTitles;
- (NSArray<UIViewController *> *)tabBarControllers;
@end
