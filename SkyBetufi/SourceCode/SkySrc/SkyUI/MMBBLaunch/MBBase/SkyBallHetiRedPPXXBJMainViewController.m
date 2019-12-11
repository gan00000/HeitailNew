#import "SkyBallHetiRedPPXXBJMainViewController.h"
#import "SkyBallHetiRedHTMatchHomeViewController.h"
#import "SkyBallHetiRedHTNewsHomeViewController.h"
#import "SkyBallHetiRedHTFilmHomeViewController.h"
#import "SkyBallHetiRedHTDataHomeViewController.h"
#import "SkyBallHetiRedHTRankHomeViewController.h"
#import "SkyBallHetiRedHTMeHomeViewController.h"
#import "SkyBallHetiRedHTUserManager.h"
#import "SkyBallHetiRedHTTabBarHomeViewController.h"
#import "SkyBallHetiRedHTNewsHomeOtherViewController.h"
#import "HTViewController2.h"

@interface SkyBallHetiRedPPXXBJMainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) SkyBallHetiRedPPXXBJNavigationController *nav1;
@property (nonatomic, strong) SkyBallHetiRedHTMatchHomeViewController *vc1;
@property (nonatomic, strong) SkyBallHetiRedPPXXBJNavigationController *nav2;
@property (nonatomic, strong) SkyBallHetiRedHTNewsHomeViewController *vc2;
@property (nonatomic, strong) SkyBallHetiRedPPXXBJNavigationController *nav3;
@property (nonatomic, strong) SkyBallHetiRedHTFilmHomeViewController *vc3;
@property (nonatomic, strong) SkyBallHetiRedPPXXBJNavigationController *nav4;
@property (nonatomic, strong) SkyBallHetiRedHTDataHomeViewController *vc4;
@property (nonatomic, strong) SkyBallHetiRedPPXXBJNavigationController *nav5;
@property (nonatomic, strong) SkyBallHetiRedHTRankHomeViewController *vc5;
@property (nonatomic, strong) SkyBallHetiRedPPXXBJNavigationController *nav6;
@property (nonatomic, strong) SkyBallHetiRedHTTabBarHomeViewController *vc6;
@end
@implementation SkyBallHetiRedPPXXBJMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     BJLog(@"SkyBallHetiRedPPXXBJMainViewController viewDidLoad");
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBA_COLOR_HEX(0x999999)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor hx_colorWithHexRGBAString:@"fc562e"]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage imageNamed:@"tab_bar_shadow"]];
    self.tabBar.translucent = NO;
    self.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 
- (NSArray<NSString *> *)waterSkytabBarTitles {
    BJLog(@"SkyBallHetiRedPPXXBJMainViewController waterSkytabBarTitles");
    if ([SkyBallHetiRedHTUserManager manager].appInView) {
        return @[@"新聞",@"比賽",  @"排行", @"數據", @"我的"];
    }
    return @[@"比賽", @"新聞", @"影片", @"數據", @"排行"];
}
- (NSArray<UIImage *> *)waterSkytabBarIcons {
     if ([SkyBallHetiRedHTUserManager manager].appInView) {
         return @[[[UIImage imageNamed:@"tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_normal5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                  [[UIImage imageNamed:@"tab_icon_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
     }
    return @[[[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIImage *> *)waterSkytabBarSelectedIcons {
    if ([SkyBallHetiRedHTUserManager manager].appInView) {
        return @[[[UIImage imageNamed:@"tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                 [[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                 [[UIImage imageNamed:@"tab_icon_selected5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                 [[UIImage imageNamed:@"tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                 [[UIImage imageNamed:@"tab_icon_me_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return @[[[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIViewController *> *)waterSkytabBarControllers {
    if (!self.vc1) {
        self.vc1 = [SkyBallHetiRedHTMatchHomeViewController waterSkyviewController];
        self.vc1.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav1 = [[SkyBallHetiRedPPXXBJNavigationController alloc] initWithRootViewController:self.vc1];
    }
    if (!self.vc2) {
        self.vc2 = [SkyBallHetiRedHTNewsHomeViewController waterSkyviewController];
        self.vc2.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav2 = [[SkyBallHetiRedPPXXBJNavigationController alloc] initWithRootViewController:self.vc2];
    }
    if (!self.vc3) {
        self.vc3 = [SkyBallHetiRedHTFilmHomeViewController waterSkyviewController];
        self.vc3.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav3 = [[SkyBallHetiRedPPXXBJNavigationController alloc] initWithRootViewController:self.vc3];
    }
    if (!self.vc4) {
        self.vc4 = [SkyBallHetiRedHTDataHomeViewController waterSkyviewController];
        self.vc4.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav4 = [[SkyBallHetiRedPPXXBJNavigationController alloc] initWithRootViewController:self.vc4];
    }
    if (!self.vc5) {
        self.vc5 = [SkyBallHetiRedHTRankHomeViewController waterSkyviewController];
        self.vc5.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav5 = [[SkyBallHetiRedPPXXBJNavigationController alloc] initWithRootViewController:self.vc5];
    }
    if (!self.vc6) {
        self.vc6 = [SkyBallHetiRedHTTabBarHomeViewController waterSkyviewController];
        self.vc6.modalPresentationStyle = UIModalPresentationFullScreen;
        self.nav6 = [[SkyBallHetiRedPPXXBJNavigationController alloc] initWithRootViewController:self.vc6];
    }
    if ([SkyBallHetiRedHTUserManager manager].appInView) {
         return @[self.nav2, self.nav1, self.nav5, self.nav4, self.nav6];
    }
    self.nav1.modalPresentationStyle = UIModalPresentationFullScreen;
     self.nav2.modalPresentationStyle = UIModalPresentationFullScreen;
     self.nav3.modalPresentationStyle = UIModalPresentationFullScreen;
     self.nav4.modalPresentationStyle = UIModalPresentationFullScreen;
     self.nav5.modalPresentationStyle = UIModalPresentationFullScreen;
    
    return @[self.nav1, self.nav2, self.nav3, self.nav4, self.nav5];
}
#pragma MARK -- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    self.currentSelectedIndex = self.selectedIndex;
//    FIRAnalytics logEventWithName
    NSLog(@"tabBarController %ld",self.currentSelectedIndex);
}
@end
