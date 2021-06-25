#import "YeYeePPXXBJNavigationController.h"
#import "NSNiceHTNewMatchHomeViewController.h"
#import "BlysaHTNewsHomeViewController.h"
#import "TuTuosHTFilmHomeViewController.h"
#import "YeYeeHTDataHomeViewController.h"
#import "YeYeeHTRankHomeViewController.h"
#import "KSasxHTTabBarHomeViewController.h"
#import "NSNiceHTNewsHomeOtherViewController.h"
#import "FFlaliPPXXBJLaunchViewController.h"
#import "FFlaliHTMainPageViewController.h"
#import "BByasMainLanmuViewController.h"

@interface YeYeePPXXBJNavigationController ()
@end
@implementation YeYeePPXXBJNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"BJNavigationController viewDidLoad %@",NSStringFromClass([self class]));
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-64)
                                                         forBarMetrics:UIBarMetricsDefault];
    
//     self.edgesForExtendedLayout = UIRectEdgeNone;
    NSDictionary *barItemAttris = @{ NSFontAttributeName : [UIFont systemFontOfSize:15 weight:UIFontWeightLight] };
    [[UIBarButtonItem appearance] setTitleTextAttributes:barItemAttris forState:UIControlStateNormal];
//    在 iOS7 以后  translucent  属性默认为 YES   该属性含义是 毛玻璃 半透明效果
//    ES  起始 坐标 为屏幕顶端 左上角 为 (0 , 0)  ,此时 UI展示的内容可透过 导航栏
//    NO   起始 坐标 为屏幕顶端 左上角 为 (0 , 20 + 44) 这个说明 起始坐标 在状态栏 和 导航栏 之下边开始 导航栏便没有毛玻璃效果了
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    UIFont *font = [UIFont systemFontOfSize:18];
    NSShadow *shadow = [[NSShadow alloc] init];
    NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSShadowAttributeName : shadow,
                                  NSFontAttributeName : font };
    [self.navigationBar setTitleTextAttributes:attributes];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSArray<Class> *)taoviewControllersNotHideTabBar {
    return @[[NSNiceHTNewMatchHomeViewController class],
             [BlysaHTNewsHomeViewController class],
             [TuTuosHTFilmHomeViewController class],
             [YeYeeHTDataHomeViewController class],
             [YeYeeHTRankHomeViewController class],
             [NSNiceHTNewsHomeOtherViewController class],
             [FFlaliPPXXBJLaunchViewController class],
             [FFlaliHTMainPageViewController class],
             [BByasMainLanmuViewController class],
             
             [KSasxHTTabBarHomeViewController class]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"BJNavigationController viewWillAppear %@",NSStringFromClass([self class]));
//    CGRect ff = self.navigationBar.frame;
//    ff.origin.y = 44;
//    self.navigationBar.frame = ff;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"BJNavigationController viewDidAppear %@",NSStringFromClass([self class]));
//    self.navigationController.navigationBar.frame = CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 44);

}
@end
