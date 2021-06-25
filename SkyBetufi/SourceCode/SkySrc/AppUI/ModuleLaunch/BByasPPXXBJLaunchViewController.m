#import "BByasPPXXBJLaunchViewController.h"
#import "CfipyPPXXBJMainViewController.h"
#import "AppDelegate.h"
#import "NSNiceBJHTTPServiceEngine.h"

#import "YeYeeDHGuidePageHUD.h"
#import "NSDate+KSasxCore.h"
#import "AFHTTPSessionManager.h"
#import "BlysaBJUtility.h"
#import "YeYeeHTMeHomeViewController.h"
#import <MMDrawerController.h>
#import "BlysaHTHomeLeftViewController.h"
#import "NSNiceHTUserRequest.h"
#import "YeYeeHTShowUpdateInfoView.h"

@interface BByasPPXXBJLaunchViewController () <CAAnimationDelegate>
@property (nonatomic, strong) CfipyPPXXBJMainViewController *tabBarController;
//@property (nonatomic,strong) MMDrawerController *drawerController;

@property (nonatomic, assign) NSInteger tryTimes;
@property (nonatomic, assign) BOOL needGuidePage;
@end
@implementation BByasPPXXBJLaunchViewController
- (void)taoGoIntoMainController {
//    [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
//    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
//    animation.duration = 0.1f;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
//    animation.type = kCATransitionFade;
//    [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//    [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = [self mmRootViewController];
}

- (void)handleAppInViewResult:(NSDictionary *)configDictionary {
    if (configDictionary) {
        NSString *version = configDictionary[@"version"];
        NSString *status = configDictionary[@"status"];
        NSString *examine = configDictionary[@"examine"];
        NSString *showTextLive = configDictionary[@"showTextLive"];
        
        NSString *appVersion = [BlysaBJUtility appVersion];
        if ([appVersion isEqualToString:version] && [examine isEqualToString:@"1"]) {
            [TuTuosHTUserManager manager].appInView = YES;
            BJLog(@"getRequestCommon in view");
        }else{
            BJLog(@"getRequestCommon not in view");
            [TuTuosHTUserManager manager].appInView = NO;
        }
        
        [TuTuosHTUserManager manager].showTextLive = YES;
    }
    
    if (!self.needGuidePage) {
        [self taoGoIntoMainController];
    }
}

- (void)handleAppInViewError {
    if (self.tryTimes == 0) {
        self.tryTimes++;
        [self taoRequestConfig];
        return;
    }
    [TuTuosHTUserManager manager].appInView = NO;
    
    if (!self.needGuidePage) {
        [self taoGoIntoMainController];
    }
}

- (void)taoRequestConfig {
    
    NSString *url = [NSString stringWithFormat:@"ios_config.json?t=%@",[[NSDate dateNow] getTimeStamp]];

//    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
//    // parameters 参数字典
//    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSDictionary *configDictionary = responseObject;
//        [self handleAppInViewResult:configDictionary];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        BJLog(@"ERROR:%@",error);
//        [self handleAppInViewError];
//
//
//    }];
   
 
    [NSNiceBJHTTPServiceEngine tao_getRequestCommon:url params:nil successBlock:^(id responseData) {
        NSDictionary *configDictionary = responseData;
        [self handleAppInViewResult:configDictionary];
        
    } errorBlock:^(WSKggBJError *error) {
        BJLog(@"ERROR:%@",error);
        [self handleAppInViewError];
        
    }];
     
}


-(void) checkUpdate
{
    [NSNiceHTUserRequest taodoCheckAppUpdateWithSuccessBlock:^(YeYeeHTUpdateInfoModel * _Nonnull kHTUpdateInfoModel) {
        
        if (kHTUpdateInfoModel && !kHTUpdateInfoModel.content) {
            
            [YeYeeHTShowUpdateInfoView showWithData:kHTUpdateInfoModel];
            
        }
        
    } failBlock:^(WSKggBJError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    BJLog(@"getRequestCommon start");
    self.tryTimes = 0;

    // 设置APP引导页
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
//        self.needGuidePage = YES;
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
//        // 静态引导页
//        [self taosetStaticGuidePage];
//
//    }else{
//        self.needGuidePage = NO;
//    }
    
    [self taoRequestConfig];
    [self checkUpdate];
    
    NSString *imageName = [NSString stringWithFormat:@"%ldx%ld", (long)(SCREEN_WIDTH*SCREEN_SCALE), (long)(SCREEN_HEIGHT*SCREEN_SCALE)];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *launchImageView = [[UIImageView alloc] init];
    launchImageView.image = image;
    [self.view addSubview:launchImageView];
    [launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [UIApplication sharedApplication].delegate.window.rootViewController = [self mmRootViewController];
}
#pragma mark - getters
- (CfipyPPXXBJMainViewController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[CfipyPPXXBJMainViewController alloc] init];
    }
    [TuTuosHTUserManager manager].mainTabBarController = _tabBarController;
    return _tabBarController;
}

-(UIViewController *)mmRootViewController
{
    if (!isAppInView) {
        return self.tabBarController;
    }
    if (self.drawerController) {
        return self.drawerController;
    }
//    UIViewController * leftSideDrawerViewController = [[MMExampleLeftSideDrawerViewController alloc] init];

//    UIViewController * centerViewController = [[MMExampleCenterTableViewController alloc] init];
    
//    UIViewController * rightSideDrawerViewController = [[MMExampleRightSideDrawerViewController alloc] init];
    
//    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:centerViewController];
//    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
//    UINavigationController * rightSideNavController = [[MMNavigationController alloc] initWithRootViewController:rightSideDrawerViewController];
//    [rightSideNavController setRestorationIdentifier:@"MMExampleRightNavigationControllerRestorationKey"];
//    UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
//    [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    
    BlysaHTHomeLeftViewController *meHomeViewController = [BlysaHTHomeLeftViewController taoviewController];
    UUaksPPXXBJNavigationController *leftNavController = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:meHomeViewController];
    
//    UUaksPPXXBJNavigationController *centerNavController = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:self.tabBarController];
    
    self.drawerController = [[MMDrawerController alloc]
                        initWithCenterViewController:self.tabBarController
                        leftDrawerViewController:leftNavController];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//         MMDrawerControllerDrawerVisualStateBlock block;
//         block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
//         if(block){
//             block(drawerController, drawerSide, percentVisible);
//         }
     }];
    self.tabBarController.drawerController = self.drawerController;
    meHomeViewController.drawerController = self.drawerController;
    return self.drawerController;
}

#pragma mark - 设置APP静态图片引导页
- (void)taosetStaticGuidePage {
    NSArray *imageNameArray;
    if ([self taoisIPhoneXSeries]) {
        imageNameArray = @[@"guideImageapp11.jpg",@"guideImageapp12.jpg",@"guideImageapp13.jpg",@"guideImageapp14.jpg", @"guideImageapp15.jpg"];
        
    }else{
        imageNameArray = @[@"guideImageapp1.jpg",@"guideImageapp2.jpg",@"guideImageapp3.jpg",@"guideImageapp4.jpg", @"guideImageapp5.jpg"];
    }
    
    
    YeYeeDHGuidePageHUD *guidePage = [[YeYeeDHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    [guidePage setClickListener:^(NSInteger m) {
          [self taoGoIntoMainController];
    }];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];

}

#pragma mark - 设置APP动态图片引导页
- (void)taosetDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    YeYeeDHGuidePageHUD *guidePage = [[YeYeeDHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
}

#pragma mark - 设置APP视频引导页
- (void)taosetVideoGuidePage {
//    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
//    YeYeeDHGuidePageHUD *guidePage = [[YeYeeDHGuidePageHUD alloc] dh_initWithFrame:self.view.bounds videoURL:videoURL];
//    [self.navigationController.view addSubview:guidePage];
}

-(BOOL)taoisIPhoneXSeries
{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

@end