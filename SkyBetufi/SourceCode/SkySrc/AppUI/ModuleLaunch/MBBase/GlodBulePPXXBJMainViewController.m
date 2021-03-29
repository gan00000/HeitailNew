#import "GlodBulePPXXBJMainViewController.h"
#import "GlodBuleHTMatchHomeViewController.h"
#import "GlodBuleHTNewsHomeViewController.h"
#import "GlodBuleHTFilmHomeViewController.h"
#import "GlodBuleHTDataHomeViewController.h"
#import "GlodBuleHTRankHomeViewController.h"
#import "GlodBuleHTMeHomeViewController.h"
#import "GlodBuleHTUserManager.h"
#import "GlodBuleHTTabBarHomeViewController.h"
#import "GlodBuleHTNewsHomeOtherViewController.h"
#import "GlodBuleHTViewController2.h"
#import "GlodBuleHTNewMatchHomeViewController.h"
#import "AppDelegate.h"

@import Firebase;
@import GoogleSignIn;

@interface GlodBulePPXXBJMainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) GlodBulePPXXBJNavigationController *nav1;
@property (nonatomic, strong) GlodBuleHTNewMatchHomeViewController *vc1;
@property (nonatomic, strong) GlodBulePPXXBJNavigationController *nav2;
@property (nonatomic, strong) GlodBuleHTNewsHomeViewController *vc2;
@property (nonatomic, strong) GlodBulePPXXBJNavigationController *nav3;
@property (nonatomic, strong) GlodBuleHTFilmHomeViewController *vc3;
@property (nonatomic, strong) GlodBulePPXXBJNavigationController *nav4;
@property (nonatomic, strong) GlodBuleHTDataHomeViewController *vc4;
@property (nonatomic, strong) GlodBulePPXXBJNavigationController *nav5;
@property (nonatomic, strong) GlodBuleHTRankHomeViewController *vc5;
@property (nonatomic, strong) GlodBulePPXXBJNavigationController *nav6;
@property (nonatomic, strong) GlodBuleHTTabBarHomeViewController *vc6;
@end
@implementation GlodBulePPXXBJMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     BJLog(@"GlodBulePPXXBJMainViewController viewDidLoad");
    
    if (@available(iOS 10.0, *)) {
        [self.tabBar setUnselectedItemTintColor:RGBA_COLOR_HEX(0x999999)];
        [self.tabBar setTintColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    } else {
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBA_COLOR_HEX(0x999999)} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"fc562e"]} forState:UIControlStateSelected];
        
    }
   
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage imageNamed:@"tab_bar_shadow"]];
    self.tabBar.translucent = NO;
    self.delegate = self;
    
    [GIDSignIn sharedInstance].presentingViewController = self;
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.pushInfo) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [app responsePushInfo:app.pushInfo fromViewController:self];
            app.pushInfo = nil;
        });
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 
- (NSArray<NSString *> *)taotabBarTitles {
    BJLog(@"GlodBulePPXXBJMainViewController taotabBarTitles");
    if ([GlodBuleHTUserManager manager].appInView) {
        return @[@"直播", @"新聞", @"數據",@"我的"];
    }
//    return @[@"比賽", @"新聞", @"影片", @"數據", @"排行"];
     return @[@"直播", @"新聞", @"影片", @"數據"];
}
- (NSArray<UIImage *> *)taotabBarIcons {
     if ([GlodBuleHTUserManager manager].appInView) {
         return @[[[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
     }
    return @[[[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIImage *> *)taotabBarSelectedIcons {
    if ([GlodBuleHTUserManager manager].appInView) {
        return  @[[[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                 [[UIImage imageNamed:@"tab_icon_me_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return @[[[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIViewController *> *)taotabBarControllers {
    if (!self.vc1) {
//        self.vc1 = [GlodBuleHTMatchHomeViewController taoviewController];
        self.vc1 = [GlodBuleHTNewMatchHomeViewController taoviewController];
//        self.vc1.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav1 = [[GlodBulePPXXBJNavigationController alloc] initWithRootViewController:self.vc1];
    }
    if (!self.vc2) {
        self.vc2 = [GlodBuleHTNewsHomeViewController taoviewController];
//        self.vc2.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav2 = [[GlodBulePPXXBJNavigationController alloc] initWithRootViewController:self.vc2];
    }
    if (!self.vc3) {
        self.vc3 = [GlodBuleHTFilmHomeViewController taoviewController];
//        self.vc3.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav3 = [[GlodBulePPXXBJNavigationController alloc] initWithRootViewController:self.vc3];
    }
    if (!self.vc4) {
        self.vc4 = [GlodBuleHTDataHomeViewController taoviewController];
//        self.vc4.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav4 = [[GlodBulePPXXBJNavigationController alloc] initWithRootViewController:self.vc4];
    }
    if (!self.vc5) {
        self.vc5 = [GlodBuleHTRankHomeViewController taoviewController];
//        self.vc5.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav5 = [[GlodBulePPXXBJNavigationController alloc] initWithRootViewController:self.vc5];
    }
    if (!self.vc6) {
        self.vc6 = [GlodBuleHTTabBarHomeViewController taoviewController];
//        self.vc6.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav6 = [[GlodBulePPXXBJNavigationController alloc] initWithRootViewController:self.vc6];
    }
    
//    self.nav1.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav2.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav3.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav4.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav5.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav6.modalPresentationStyle = UIModalPresentationFullScreen;
      
    if ([GlodBuleHTUserManager manager].appInView) {
         return @[self.nav1, self.nav2, self.nav4, self.nav6];
    }
  
    return @[self.nav1, self.nav2, self.nav3, self.nav4];
}
#pragma MARK -- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    self.currentSelectedIndex = self.selectedIndex;
//    FIRAnalytics logEventWithName
   
    [viewController viewDidAppear:YES];
    NSLog(@"tabBarController %ld",self.currentSelectedIndex);
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//        NSLog(@"被选中的控制器将要显示的按钮");
          //return NO;不能显示选中的控制器
     [viewController viewWillAppear:YES];
    
    return YES;
}
@end
