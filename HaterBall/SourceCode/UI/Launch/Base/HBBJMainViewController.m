#import "HBBJMainViewController.h"
#import "HBMatchHomeViewController.h"
#import "HBNewsHomeViewController.h"
#import "HBFilmHomeViewController.h"
#import "HBDataHomeViewController.h"
#import "HBRankHomeViewController.h"
@interface HBBJMainViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) HBBJNavigationController *nav1;
@property (nonatomic, strong) HBMatchHomeViewController *vc1;
@property (nonatomic, strong) HBBJNavigationController *nav2;
@property (nonatomic, strong) HBNewsHomeViewController *vc2;
@property (nonatomic, strong) HBBJNavigationController *nav3;
@property (nonatomic, strong) HBFilmHomeViewController *vc3;
@property (nonatomic, strong) HBBJNavigationController *nav4;
@property (nonatomic, strong) HBDataHomeViewController *vc4;
@property (nonatomic, strong) HBBJNavigationController *nav5;
@property (nonatomic, strong) HBRankHomeViewController *vc5;
@end
@implementation HBBJMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBA_COLOR_HEX(0x999999)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
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
- (NSArray<NSString *> *)tabBarTitles {
    return @[@"比賽", @"新聞", @"影片", @"數據", @"排行"];
}
- (NSArray<UIImage *> *)tabBarIcons {
    return @[[[UIImage imageNamed:@"tab_icon_normal1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_normal5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIImage *> *)tabBarSelectedIcons {
    return @[[[UIImage imageNamed:@"tab_icon_selected1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             [[UIImage imageNamed:@"tab_icon_selected5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
- (NSArray<UIViewController *> *)tabBarControllers {
    if (!self.vc1) {
        self.vc1 = [HBMatchHomeViewController viewController];
        self.nav1 = [[HBBJNavigationController alloc] initWithRootViewController:self.vc1];
    }
    if (!self.vc2) {
        self.vc2 = [HBNewsHomeViewController viewController];
        self.nav2 = [[HBBJNavigationController alloc] initWithRootViewController:self.vc2];
    }
    if (!self.vc3) {
        self.vc3 = [HBFilmHomeViewController viewController];
        self.nav3 = [[HBBJNavigationController alloc] initWithRootViewController:self.vc3];
    }
    if (!self.vc4) {
        self.vc4 = [HBDataHomeViewController viewController];
        self.nav4 = [[HBBJNavigationController alloc] initWithRootViewController:self.vc4];
    }
    if (!self.vc5) {
        self.vc5 = [HBRankHomeViewController viewController];
        self.nav5 = [[HBBJNavigationController alloc] initWithRootViewController:self.vc5];
    }
    return @[self.nav1, self.nav2, self.nav3, self.nav4, self.nav5];
}
#pragma MARK -- UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    self.currentSelectedIndex = self.selectedIndex;
}
@end
