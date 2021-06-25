#import "CfipyPPXXBJMainViewController.h"
#import "BByasHTMatchHomeViewController.h"
#import "KSasxHTNewsHomeViewController.h"
#import "CfipyHTFilmHomeViewController.h"
#import "BlysaHTDataHomeViewController.h"
#import "WSKggHTRankHomeViewController.h"
#import "YeYeeHTMeHomeViewController.h"
#import "TuTuosHTUserManager.h"
#import "NSNiceHTTabBarHomeViewController.h"
#import "BlysaHTNewsHomeOtherViewController.h"
#import "TuTuosHTViewController2.h"
#import "FFlaliHTNewMatchHomeViewController.h"
#import "AppDelegate.h"

#import "CfipyHTCollectionViewController.h"
#import "KSasxHTMessageViewController.h"
#import "WSKggHTUserInfoEditViewController.h"
#import "FFlaliHTCommentViewController.h"
#import "BlysaHTLikeViewController.h"
#import "UUaksHTHistoryViewController.h"
#import "NSNiceHTSettingViewController.h"
#import "NSNiceHTMainPageViewController.h"
#import "UUaksMainLanmuViewController.h"


@import Firebase;
@import GoogleSignIn;

@interface CfipyPPXXBJMainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) UUaksPPXXBJNavigationController *nav1;
@property (nonatomic, strong) FFlaliHTNewMatchHomeViewController *vc1;
@property (nonatomic, strong) UUaksPPXXBJNavigationController *nav2;
@property (nonatomic, strong) KSasxHTNewsHomeViewController *vc2;
@property (nonatomic, strong) UUaksPPXXBJNavigationController *nav3;
@property (nonatomic, strong) CfipyHTFilmHomeViewController *vc3;
@property (nonatomic, strong) UUaksPPXXBJNavigationController *nav4;
@property (nonatomic, strong) BlysaHTDataHomeViewController *vc4;
@property (nonatomic, strong) UUaksPPXXBJNavigationController *nav5;
@property (nonatomic, strong) WSKggHTRankHomeViewController *vc5;
@property (nonatomic, strong) UUaksPPXXBJNavigationController *nav6;
@property (nonatomic, strong) NSNiceHTTabBarHomeViewController *vc6;


@property (nonatomic, strong) UUaksPPXXBJNavigationController *nav7;
@property (nonatomic, strong) UUaksMainLanmuViewController *vc7;


@property (nonatomic, strong) UUaksPPXXBJNavigationController *nav0;
@property (nonatomic, strong) NSNiceHTMainPageViewController *vc0;

@property (nonatomic, strong)   UIViewController *currentNavViewController;
    
@end
@implementation CfipyPPXXBJMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     BJLog(@"CfipyPPXXBJMainViewController viewDidLoad");
    
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
    BJLog(@"CfipyPPXXBJMainViewController taotabBarTitles");
    if (isAppInView) {
        return @[@"首頁",@"賽事", @"欄目"];
    }
//    return @[@"比賽", @"新聞", @"影片", @"數據", @"排行"];
     return @[@"首頁",@"直播", @"新聞", @"影片", @"數據"];
}
- (NSArray<UIImage *> *)taotabBarIcons {
     if (isAppInView) {
         return @[
             [[UIImage imageNamed:@"gurk_tab_xxx_mainpage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_xxx_match"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_xxx_lanmu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//                  [[UIImage imageNamed:@"gurk_tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"gurk_tab_xxx_match"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"gurk_tab_xxx_data"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
     }
    return @[[[UIImage imageNamed:@"gurk_tab_main_page_unselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIImage *> *)taotabBarSelectedIcons {
    if (isAppInView) {
        return  @[[[UIImage imageNamed:@"gurk_tab_xxx_mainpage_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"gurk_tab_xxx_match_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"gurk_tab_xxx_lanmu_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//                  [[UIImage imageNamed:@"gurk_tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                  [[UIImage imageNamed:@"gurk_tab_xxx_match_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                 [[UIImage imageNamed:@"gurk_tab_xxx_data_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return @[
             [[UIImage imageNamed:@"gurk_tab_main_page_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"gurk_tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIViewController *> *)taotabBarControllers {
    
    if (!self.vc0) {
        self.vc0 = [NSNiceHTMainPageViewController taoviewController];
        self.nav0 = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.vc0];
    }
    
    if (!self.vc1) {
        self.vc1 = [FFlaliHTNewMatchHomeViewController taoviewController];
        self.nav1 = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.vc1];
    }
    if (!self.vc2) {
        self.vc2 = [KSasxHTNewsHomeViewController taoviewController];
        self.nav2 = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.vc2];
    }
    if (!self.vc3) {
        self.vc3 = [CfipyHTFilmHomeViewController taoviewController];
        self.nav3 = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.vc3];
    }
    if (!self.vc4) {
        self.vc4 = [BlysaHTDataHomeViewController taoviewController];
        self.nav4 = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.vc4];
    }
    if (!self.vc5) {
        self.vc5 = [WSKggHTRankHomeViewController taoviewController];
        self.nav5 = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.vc5];
    }
    if (!self.vc6) {
        self.vc6 = [NSNiceHTTabBarHomeViewController taoviewController];
        self.nav6 = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.vc6];
    }
    
    if (!self.vc7) {
        self.vc7 = [UUaksMainLanmuViewController taoviewController];
        self.nav7 = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.vc7];
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
        UUaksPPXXBJNavigationController *aaNavViewController = (UUaksPPXXBJNavigationController *)viewController;
       NSArray *vcs = aaNavViewController.viewControllers;
        if (vcs && vcs.count > 0) {
            UIViewController *viewController = vcs[0];
            if ([viewController isKindOfClass:[NSNiceHTMainPageViewController class]]) {
                NSNiceHTMainPageViewController *mpVC = (NSNiceHTMainPageViewController *)viewController;
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
                    viewController = [WSKggHTUserInfoEditViewController taoviewController];
                    break;
                case 1:
                    viewController = [CfipyHTCollectionViewController taoviewController];
                    break;
                case 2:
                    viewController = [FFlaliHTCommentViewController taoviewController];
                    break;
                case 3:
                    viewController = [BlysaHTLikeViewController taoviewController];
                    break;
                case 4:
                    viewController = [UUaksHTHistoryViewController taoviewController];
                    break;
                case 5:
                    viewController = [KSasxHTMessageViewController taoviewController];
                    break;
                case 6:
                    viewController = [NSNiceHTSettingViewController taoviewController];
                    break;
                    
                default:
                    break;
            }
            
            UUaksPPXXBJNavigationController *xxcurrentNavViewController = (UUaksPPXXBJNavigationController *)self.currentNavViewController;
            if (xxcurrentNavViewController && viewController) {
                [xxcurrentNavViewController pushViewController:viewController animated:YES];
            }
            
        }
    }
}

@end
