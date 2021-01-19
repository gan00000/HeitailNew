#import <UIKit/UIKit.h>
@protocol BJNavigationDelegate <NSObject>
@optional
- (BOOL)tao_shouldHandlePopActionMySelf;
- (void)tao_handlePopActionMySelf;
- (BOOL)tao_shouldForbidSlideBackAction;
- (BOOL)tao_shouldHideNavigationBar;
- (void)tao_handleNavBack;
@end
@interface GlodBulePPXXBJBaseNavigationController : UINavigationController
- (NSArray<Class> *)taoviewControllersNotHideTabBar;
@end
