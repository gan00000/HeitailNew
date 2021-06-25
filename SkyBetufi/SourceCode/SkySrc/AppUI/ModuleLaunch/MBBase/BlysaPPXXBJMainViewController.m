#import "BlysaPPXXBJMainViewController.h"
#import "BlysaHTMatchHomeViewController.h"
#import "BlysaHTNewsHomeViewController.h"
#import "TuTuosHTFilmHomeViewController.h"
#import "YeYeeHTDataHomeViewController.h"
#import "YeYeeHTRankHomeViewController.h"
#import "TuTuosHTMeHomeViewController.h"
#import "NSNiceHTUserManager.h"
#import "KSasxHTTabBarHomeViewController.h"
#import "NSNiceHTNewsHomeOtherViewController.h"
#import "KSasxHTViewController2.h"
#import "NSNiceHTNewMatchHomeViewController.h"
#import "AppDelegate.h"

#import "WSKggHTCollectionViewController.h"
#import "NSNiceHTMessageViewController.h"
#import "FFlaliHTUserInfoEditViewController.h"
#import "YeYeeHTCommentViewController.h"
#import "KSasxHTLikeViewController.h"
#import "BByasHTHistoryViewController.h"
#import "FFlaliHTSettingViewController.h"
#import "FFlaliHTMainPageViewController.h"
#import "BByasMainLanmuViewController.h"


@import Firebase;
@import GoogleSignIn;

@interface BlysaPPXXBJMainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) YeYeePPXXBJNavigationController *nav1;
@property (nonatomic, strong) NSNiceHTNewMatchHomeViewController *vc1;
@property (nonatomic, strong) YeYeePPXXBJNavigationController *nav2;
@property (nonatomic, strong) BlysaHTNewsHomeViewController *vc2;
@property (nonatomic, strong) YeYeePPXXBJNavigationController *nav3;
@property (nonatomic, strong) TuTuosHTFilmHomeViewController *vc3;
@property (nonatomic, strong) YeYeePPXXBJNavigationController *nav4;
@property (nonatomic, strong) YeYeeHTDataHomeViewController *vc4;
@property (nonatomic, strong) YeYeePPXXBJNavigationController *nav5;
@property (nonatomic, strong) YeYeeHTRankHomeViewController *vc5;
@property (nonatomic, strong) YeYeePPXXBJNavigationController *nav6;
@property (nonatomic, strong) KSasxHTTabBarHomeViewController *vc6;


@property (nonatomic, strong) YeYeePPXXBJNavigationController *nav7;
@property (nonatomic, strong) BByasMainLanmuViewController *vc7;


@property (nonatomic, strong) YeYeePPXXBJNavigationController *nav0;
@property (nonatomic, strong) FFlaliHTMainPageViewController *vc0;

@property (nonatomic, strong)   UIViewController *currentNavViewController;
    
@end
@implementation BlysaPPXXBJMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     BJLog(@"BlysaPPXXBJMainViewController viewDidLoad");
    
    UIColor *tintColor = appBaseColor;
    UIColor *unselectedItemTintColor = RGBA_COLOR_HEX(0x999999);
    
    if (isAppInView) {
        tintColor = UIColor.whiteColor;
        unselectedItemTintColor = UIColor.blackColor;
    }
    
    if (@available(iOS 10.0, *)) {
        [self.tabBar setUnselectedItemTintColor:unselectedItemTintColor];
        [self.tabBar setTintColor:tintColor];
    } else {
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectedItemTintColor} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:tintColor} forState:UIControlStateSelected];
        
    }
   
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    self.tabBar.translucent = NO;
    
    if (isAppInView) {
        
        [self.tabBar setBackgroundImage:[UIImage jx_imageWithColor:appBaseColor]];
        [self.tabBar setShadowImage:[UIImage imageNamed:@"tab_bar_shadow"]];
       
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:left_controller_click_name
                                                   object:nil];
    }else{
        [self.tabBar setBackgroundImage:[UIImage new]];
        [self.tabBar setShadowImage:[UIImage imageNamed:@"tab_bar_shadow"]];
    }
   
    self.delegate = self;
    
//    [GIDSignIn sharedInstance].presentingViewController = self;
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.pushInfo) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [app responsePushInfo:app.pushInfo fromViewController:self];
            app.pushInfo = nil;
        });
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 
- (NSArray<NSString *> *)taotabBarTitles {
    BJLog(@"BlysaPPXXBJMainViewController taotabBarTitles");
    if (isAppInView) {
        return @[@"首頁",@"賽事", @"欄目"];
    }
//    return @[@"比賽", @"新聞", @"影片", @"數據", @"排行"];
     return @[@"首頁",@"直播", @"新聞", @"影片", @"數據"];
}
- (NSArray<UIImage *> *)taotabBarIcons {
     if (isAppInView) {
         return @[
             [[UIImage imageNamed:@"tab_xxx_mainpage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_xxx_match"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_xxx_lanmu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//                  [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"tab_xxx_match"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"tab_xxx_data"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
     }
    return @[[[UIImage imageNamed:@"tab_main_page_unselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIImage *> *)taotabBarSelectedIcons {
    if (isAppInView) {
        return  @[[[UIImage imageNamed:@"tab_xxx_mainpage_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_xxx_match_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_xxx_lanmu_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//                  [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"tab_xxx_match_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                 [[UIImage imageNamed:@"tab_xxx_data_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return @[
             [[UIImage imageNamed:@"tab_main_page_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIViewController *> *)taotabBarControllers {
    
    if (!self.vc0) {
        self.vc0 = [FFlaliHTMainPageViewController taoviewController];
        self.nav0 = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:self.vc0];
    }
    
    if (!self.vc1) {
        self.vc1 = [NSNiceHTNewMatchHomeViewController taoviewController];
        self.nav1 = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:self.vc1];
    }
    if (!self.vc2) {
        self.vc2 = [BlysaHTNewsHomeViewController taoviewController];
        self.nav2 = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:self.vc2];
    }
    if (!self.vc3) {
        self.vc3 = [TuTuosHTFilmHomeViewController taoviewController];
        self.nav3 = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:self.vc3];
    }
    if (!self.vc4) {
        self.vc4 = [YeYeeHTDataHomeViewController taoviewController];
        self.nav4 = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:self.vc4];
    }
    if (!self.vc5) {
        self.vc5 = [YeYeeHTRankHomeViewController taoviewController];
        self.nav5 = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:self.vc5];
    }
    if (!self.vc6) {
        self.vc6 = [KSasxHTTabBarHomeViewController taoviewController];
        self.nav6 = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:self.vc6];
    }
    
    if (!self.vc7) {
        self.vc7 = [BByasMainLanmuViewController taoviewController];
        self.nav7 = [[YeYeePPXXBJNavigationController alloc] initWithRootViewController:self.vc7];
    }
    
//    self.nav1.modalPresentationStyle = UIModalPresentationFullScreen;
    
    self.currentNavViewController = self.nav0;
    
    if (isAppInView) {
         return @[self.nav0, self.nav1, self.nav7];
    }
  
    return @[self.nav0, self.nav1, self.nav2, self.nav3, self.nav4];
}
#pragma MARK -- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (self.currentSelectedIndex == 0 && self.selectedIndex == 0) {
        YeYeePPXXBJNavigationController *aaNavViewController = (YeYeePPXXBJNavigationController *)viewController;
       NSArray *vcs = aaNavViewController.viewControllers;
        if (vcs && vcs.count > 0) {
            UIViewController *viewController = vcs[0];
            if ([viewController isKindOfClass:[FFlaliHTMainPageViewController class]]) {
                FFlaliHTMainPageViewController *mpVC = (FFlaliHTMainPageViewController *)viewController;
                [mpVC clickTab];
            }
        }
        
    }
    self.currentSelectedIndex = self.selectedIndex;
//    FIRAnalytics logEventWithName
   
//    [viewController viewDidAppear:YES];
    NSLog(@"tabBarController %ld",self.currentSelectedIndex);
    self.currentNavViewController = viewController;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//        NSLog(@"被选中的控制器将要显示的按钮");
          //return NO;不能显示选中的控制器
     [viewController viewWillAppear:YES];
    
    return YES;
}


- (void)handleNotification:(NSNotification *)notification
{
    NSLog(@"notification = %@", notification.name);
    NSDictionary *info = notification.userInfo;
    if (info) {
        NSString *index = info[@"index"];
        if (index) {
            int xxIndex = index.intValue;
            [self.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
            
            UIViewController *viewController;
            switch (xxIndex) {
                case 0:
                    viewController = [FFlaliHTUserInfoEditViewController taoviewController];
                    break;
                case 1:
                    viewController = [WSKggHTCollectionViewController taoviewController];
                    break;
                case 2:
                    viewController = [YeYeeHTCommentViewController taoviewController];
                    break;
                case 3:
                    viewController = [KSasxHTLikeViewController taoviewController];
                    break;
                case 4:
                    viewController = [BByasHTHistoryViewController taoviewController];
                    break;
                case 5:
                    viewController = [NSNiceHTMessageViewController taoviewController];
                    break;
                case 6:
                    viewController = [FFlaliHTSettingViewController taoviewController];
                    break;
                    
                default:
                    break;
            }
            
            YeYeePPXXBJNavigationController *xxcurrentNavViewController = (YeYeePPXXBJNavigationController *)self.currentNavViewController;
            if (xxcurrentNavViewController && viewController) {
                [xxcurrentNavViewController pushViewController:viewController animated:YES];
            }
            
        }
    }
}

@end
