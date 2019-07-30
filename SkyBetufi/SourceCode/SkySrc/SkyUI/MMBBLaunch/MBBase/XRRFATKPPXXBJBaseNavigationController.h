#import <UIKit/UIKit.h>
@protocol BJNavigationDelegate <NSObject>
@optional
- (BOOL)skarg_shouldHandlePopActionMySelf;
- (void)skarg_handlePopActionMySelf;
- (BOOL)skarg_shouldForbidSlideBackAction;
- (BOOL)skarg_shouldHideNavigationBar;
@end
@interface XRRFATKPPXXBJBaseNavigationController : UINavigationController
- (NSArray<Class> *)skargviewControllersNotHideTabBar;
@end
