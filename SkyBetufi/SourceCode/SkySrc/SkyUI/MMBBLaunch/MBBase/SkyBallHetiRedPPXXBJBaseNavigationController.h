#import <UIKit/UIKit.h>
@protocol BJNavigationDelegate <NSObject>
@optional
- (BOOL)waterSky_shouldHandlePopActionMySelf;
- (void)waterSky_handlePopActionMySelf;
- (BOOL)waterSky_shouldForbidSlideBackAction;
- (BOOL)waterSky_shouldHideNavigationBar;
- (void)waterSky_handleNavBack;
@end
@interface SkyBallHetiRedPPXXBJBaseNavigationController : UINavigationController
- (NSArray<Class> *)waterSkyviewControllersNotHideTabBar;
@end
