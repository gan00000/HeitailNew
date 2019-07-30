#import "XRRFATKPPXXBJMainViewController.h"
#import "XRRFATKHTMatchHomeViewController.h"
#import "XRRFATKHTNewsHomeViewController.h"
#import "XRRFATKHTFilmHomeViewController.h"
#import "XRRFATKHTDataHomeViewController.h"
#import "XRRFATKHTRankHomeViewController.h"
#import "XRRFATKHTMeHomeViewController.h"
#import "XRRFATKHTUserManager.h"
#import "XRRFATKHTTabBarHomeViewController.h"
#import "XRRFATKHTNewsHomeOtherViewController.h"
@interface XRRFATKPPXXBJMainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) XRRFATKPPXXBJNavigationController *nav1;
@property (nonatomic, strong) XRRFATKHTMatchHomeViewController *vc1;
@property (nonatomic, strong) XRRFATKPPXXBJNavigationController *nav2;
@property (nonatomic, strong) XRRFATKHTNewsHomeViewController *vc2;
@property (nonatomic, strong) XRRFATKPPXXBJNavigationController *nav3;
@property (nonatomic, strong) XRRFATKHTFilmHomeViewController *vc3;
@property (nonatomic, strong) XRRFATKPPXXBJNavigationController *nav4;
@property (nonatomic, strong) XRRFATKHTDataHomeViewController *vc4;
@property (nonatomic, strong) XRRFATKPPXXBJNavigationController *nav5;
@property (nonatomic, strong) XRRFATKHTRankHomeViewController *vc5;
@property (nonatomic, strong) XRRFATKPPXXBJNavigationController *nav6;
@property (nonatomic, strong) XRRFATKHTTabBarHomeViewController *vc6;
@end
@implementation XRRFATKPPXXBJMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     BJLog(@"XRRFATKPPXXBJMainViewController viewDidLoad");
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
- (NSArray<NSString *> *)skargtabBarTitles {
    BJLog(@"XRRFATKPPXXBJMainViewController skargtabBarTitles");
    if ([XRRFATKHTUserManager manager].appInView) {
        return @[@"新聞",@"比賽",  @"排行", @"數據", @"我的"];
    }
    return @[@"比賽", @"新聞", @"影片", @"數據", @"排行"];
}
- (NSArray<UIImage *> *)skargtabBarIcons {
     if ([XRRFATKHTUserManager manager].appInView) {
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
- (NSArray<UIImage *> *)skargtabBarSelectedIcons {
    if ([XRRFATKHTUserManager manager].appInView) {
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
- (NSArray<UIViewController *> *)skargtabBarControllers {
    if (!self.vc1) {
        self.vc1 = [XRRFATKHTMatchHomeViewController skargviewController];
        self.nav1 = [[XRRFATKPPXXBJNavigationController alloc] initWithRootViewController:self.vc1];
    }
    if (!self.vc2) {
        self.vc2 = [XRRFATKHTNewsHomeViewController skargviewController];
        self.nav2 = [[XRRFATKPPXXBJNavigationController alloc] initWithRootViewController:self.vc2];
    }
    if (!self.vc3) {
        self.vc3 = [XRRFATKHTFilmHomeViewController skargviewController];
        self.nav3 = [[XRRFATKPPXXBJNavigationController alloc] initWithRootViewController:self.vc3];
    }
    if (!self.vc4) {
        self.vc4 = [XRRFATKHTDataHomeViewController skargviewController];
        self.nav4 = [[XRRFATKPPXXBJNavigationController alloc] initWithRootViewController:self.vc4];
    }
    if (!self.vc5) {
        self.vc5 = [XRRFATKHTRankHomeViewController skargviewController];
        self.nav5 = [[XRRFATKPPXXBJNavigationController alloc] initWithRootViewController:self.vc5];
    }
    if (!self.vc6) {
        self.vc6 = [XRRFATKHTTabBarHomeViewController skargviewController];
        self.nav6 = [[XRRFATKPPXXBJNavigationController alloc] initWithRootViewController:self.vc6];
    }
    if ([XRRFATKHTUserManager manager].appInView) {
         return @[self.nav2, self.nav1, self.nav5, self.nav4, self.nav6];
    }
    return @[self.nav1, self.nav2, self.nav3, self.nav4, self.nav5];
}
#pragma MARK -- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    self.currentSelectedIndex = self.selectedIndex;
}
@end
