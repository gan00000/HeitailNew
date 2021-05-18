#import "PXFunPPXXBJMainViewController.h"
#import "YYPackageHTMatchHomeViewController.h"
#import "NDeskHTNewsHomeViewController.h"
#import "RRDogHTFilmHomeViewController.h"
#import "MMTodayHTDataHomeViewController.h"
#import "CCCaseHTRankHomeViewController.h"
#import "MMTodayHTMeHomeViewController.h"
#import "MMTodayHTUserManager.h"
#import "GGCatHTTabBarHomeViewController.h"
#import "HourseHTNewsHomeOtherViewController.h"
#import "PXFunHTViewController2.h"
#import "NDeskHTNewMatchHomeViewController.h"
#import "AppDelegate.h"

#import "RRDogHTCollectionViewController.h"
#import "CCCaseHTMessageViewController.h"
#import "GGCatHTUserInfoEditViewController.h"
#import "KMonkeyHTCommentViewController.h"
#import "CCCaseHTLikeViewController.h"
#import "CCCaseHTHistoryViewController.h"
#import "NDeskHTSettingViewController.h"
#import "HourseHTMainPageViewController.h"

@import Firebase;
@import GoogleSignIn;

@interface PXFunPPXXBJMainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) HoursePPXXBJNavigationController *nav1;
@property (nonatomic, strong) NDeskHTNewMatchHomeViewController *vc1;
@property (nonatomic, strong) HoursePPXXBJNavigationController *nav2;
@property (nonatomic, strong) NDeskHTNewsHomeViewController *vc2;
@property (nonatomic, strong) HoursePPXXBJNavigationController *nav3;
@property (nonatomic, strong) RRDogHTFilmHomeViewController *vc3;
@property (nonatomic, strong) HoursePPXXBJNavigationController *nav4;
@property (nonatomic, strong) MMTodayHTDataHomeViewController *vc4;
@property (nonatomic, strong) HoursePPXXBJNavigationController *nav5;
@property (nonatomic, strong) CCCaseHTRankHomeViewController *vc5;
@property (nonatomic, strong) HoursePPXXBJNavigationController *nav6;
@property (nonatomic, strong) GGCatHTTabBarHomeViewController *vc6;


@property (nonatomic, strong) HoursePPXXBJNavigationController *nav0;
@property (nonatomic, strong) HourseHTMainPageViewController *vc0;

@property (nonatomic, strong)   UIViewController *currentBarViewController;
    
@end
@implementation PXFunPPXXBJMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     BJLog(@"PXFunPPXXBJMainViewController viewDidLoad");
    
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
    BJLog(@"PXFunPPXXBJMainViewController taotabBarTitles");
    if (isAppInView) {
        return @[@"首頁",@"資訊", @"短片", @"賽事",  @"統計"];
    }
//    return @[@"比賽", @"新聞", @"影片", @"數據", @"排行"];
     return @[@"首頁",@"直播", @"新聞", @"影片", @"數據"];
}
- (NSArray<UIImage *> *)taotabBarIcons {
     if (isAppInView) {
         return @[
             [[UIImage imageNamed:@"tab_xxx_mainpage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_xxx_news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_xxx_film"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_xxx_match"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_xxx_data"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
     }
    return @[[[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIImage *> *)taotabBarSelectedIcons {
    if (isAppInView) {
        return  @[[[UIImage imageNamed:@"tab_xxx_mainpage_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_xxx_news_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_xxx_film_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_xxx_match_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                 [[UIImage imageNamed:@"tab_xxx_data_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return @[
        [[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIViewController *> *)taotabBarControllers {
    
    if (!self.vc0) {
        self.vc0 = [HourseHTMainPageViewController taoviewController];
        self.nav0 = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:self.vc0];
    }
    
    if (!self.vc1) {
//        self.vc1 = [YYPackageHTMatchHomeViewController taoviewController];
        self.vc1 = [NDeskHTNewMatchHomeViewController taoviewController];
//        self.vc1.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav1 = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:self.vc1];
    }
    if (!self.vc2) {
        self.vc2 = [NDeskHTNewsHomeViewController taoviewController];
//        self.vc2.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav2 = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:self.vc2];
    }
    if (!self.vc3) {
        self.vc3 = [RRDogHTFilmHomeViewController taoviewController];
//        self.vc3.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav3 = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:self.vc3];
    }
    if (!self.vc4) {
        self.vc4 = [MMTodayHTDataHomeViewController taoviewController];
//        self.vc4.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav4 = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:self.vc4];
    }
    if (!self.vc5) {
        self.vc5 = [CCCaseHTRankHomeViewController taoviewController];
//        self.vc5.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav5 = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:self.vc5];
    }
    if (!self.vc6) {
        self.vc6 = [GGCatHTTabBarHomeViewController taoviewController];
//        self.vc6.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav6 = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:self.vc6];
    }
    
//    self.nav1.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav2.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav3.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav4.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav5.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.nav6.modalPresentationStyle = UIModalPresentationFullScreen;
    
    self.currentBarViewController = self.nav0;
    
    if (isAppInView) {
         return @[self.nav0, self.nav2, self.nav3, self.nav1, self.nav4];
    }
  
    return @[self.nav0, self.nav1, self.nav2, self.nav3, self.nav4];
}
#pragma MARK -- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    self.currentSelectedIndex = self.selectedIndex;
//    FIRAnalytics logEventWithName
   
//    [viewController viewDidAppear:YES];
    NSLog(@"tabBarController %ld",self.currentSelectedIndex);
    self.currentBarViewController = viewController;
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
                    viewController = [GGCatHTUserInfoEditViewController taoviewController];
                    break;
                case 1:
                    viewController = [RRDogHTCollectionViewController taoviewController];
                    break;
                case 2:
                    viewController = [KMonkeyHTCommentViewController taoviewController];
                    break;
                case 3:
                    viewController = [CCCaseHTLikeViewController taoviewController];
                    break;
                case 4:
                    viewController = [CCCaseHTHistoryViewController taoviewController];
                    break;
                case 5:
                    viewController = [CCCaseHTMessageViewController taoviewController];
                    break;
                case 6:
                    viewController = [NDeskHTSettingViewController taoviewController];
                    break;
                    
                default:
                    break;
            }
            
            HoursePPXXBJNavigationController *xxcurrentBarViewController = (HoursePPXXBJNavigationController *)self.currentBarViewController;
            if (xxcurrentBarViewController && viewController) {
                [xxcurrentBarViewController pushViewController:viewController animated:YES];
            }
            
        }
    }
}

@end
