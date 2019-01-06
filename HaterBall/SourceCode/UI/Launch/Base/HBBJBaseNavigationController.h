#import <UIKit/UIKit.h>
@protocol BJNavigationDelegate <NSObject>
@optional
- (BOOL)bj_shouldHandlePopActionMySelf;
- (void)bj_handlePopActionMySelf;
- (BOOL)bj_shouldForbidSlideBackAction;
- (BOOL)bj_shouldHideNavigationBar;
@end
@interface HBBJBaseNavigationController : UINavigationController
- (NSArray<Class> *)viewControllersNotHideTabBar;
@end
