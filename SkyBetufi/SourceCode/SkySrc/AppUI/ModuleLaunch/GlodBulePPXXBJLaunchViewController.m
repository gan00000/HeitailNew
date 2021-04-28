#import "GlodBulePPXXBJLaunchViewController.h"
#import "GlodBulePPXXBJMainViewController.h"
#import "AppDelegate.h"
#import "GlodBuleBJHTTPServiceEngine.h"

#import "GlodBuleDHGuidePageHUD.h"
#import "NSDate+GlodBuleCore.h"
#import "AFHTTPSessionManager.h"
#import "GlodBuleBJUtility.h"

@interface GlodBulePPXXBJLaunchViewController () <CAAnimationDelegate>
@property (nonatomic, strong) GlodBulePPXXBJMainViewController *tabBarController;
@property (nonatomic, assign) NSInteger tryTimes;
@property (nonatomic, assign) BOOL needGuidePage;
@end
@implementation GlodBulePPXXBJLaunchViewController
- (void)taoGoIntoMainController {
//    [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
//    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
//    animation.duration = 0.1f;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
//    animation.type = kCATransitionFade;
//    [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//    [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
    
    [UIApplication sharedApplication].delegate.window.rootViewController = self.tabBarController;
}

- (void)taoRequestConfig {
    NSString *url = [NSString stringWithFormat:@"http://nba-007.com/ios_config.json?t=%@",[[NSDate dateNow] getTimeStamp]];
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    // parameters 参数字典
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *configDictionary = responseObject;
        if (configDictionary) {
            NSString *version = configDictionary[@"version"];
            NSString *status = configDictionary[@"status"];
            NSString *examine = configDictionary[@"examine"];
            NSString *showTextLive = configDictionary[@"showTextLive"];
            
            NSString *appVersion = [GlodBuleBJUtility appVersion];
            if ([appVersion isEqualToString:version] && [examine isEqualToString:@"1"]) {
                [GlodBuleHTUserManager manager].appInView = YES;
                BJLog(@"getRequestCommon in view");
            }else{
                BJLog(@"getRequestCommon not in view");
                [GlodBuleHTUserManager manager].appInView = NO;
            }

            [GlodBuleHTUserManager manager].showTextLive = YES;
        }
        
        if (!self.needGuidePage) {
            [self taoGoIntoMainController];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BJLog(@"ERROR:%@",error);
        if (self.tryTimes == 0) {
            self.tryTimes++;
            [self taoRequestConfig];
            return;
        }
        [GlodBuleHTUserManager manager].appInView = NO;
        
        if (!self.needGuidePage) {
            [self taoGoIntoMainController];
        }
        
        
    }];
   
    /**

    [GlodBuleBJHTTPServiceEngine tao_getRequestCommon:url params:nil successBlock:^(id responseData) {
        NSDictionary *configDictionary = responseData; 
        if (configDictionary) {
            NSString *version = configDictionary[@"version"];
            NSString *status = configDictionary[@"status"];
            NSString *examine = configDictionary[@"examine"];
            NSString *showTextLive = configDictionary[@"showTextLive"];
            
            NSString *appVersion = [GlodBuleBJUtility appVersion];
            if ([appVersion isEqualToString:version] && [examine isEqualToString:@"1"]) {
                [GlodBuleHTUserManager manager].appInView = YES;
                BJLog(@"getRequestCommon in view");
            }else{
                BJLog(@"getRequestCommon not in view");
                [GlodBuleHTUserManager manager].appInView = NO;
            }
//             [GlodBuleHTUserManager manager].appInView = YES;
//            if ([showTextLive isEqualToString:@"1"]) {//是否显示文字直播
//                [GlodBuleHTUserManager manager].showTextLive = YES;
//
//            }else{
//
//                [GlodBuleHTUserManager manager].showTextLive = NO;//showTextLive 0 是不显示
//            }
             [GlodBuleHTUserManager manager].showTextLive = YES;
        }
        
        if (!self.needGuidePage) {
            [self taoGoIntoMainController];
        }
        
    } errorBlock:^(GlodBuleBJError *error) {
        BJLog(@"ERROR:%@",error);
        if (self.tryTimes == 0) {
            self.tryTimes++;
            [self taoRequestConfig];
            return;
        }
        [GlodBuleHTUserManager manager].appInView = NO;
        
        if (!self.needGuidePage) {
            [self taoGoIntoMainController];
        }
        
    }];
     
     */
}
- (void)viewDidLoad {
    [super viewDidLoad];
    BJLog(@"getRequestCommon start");
    self.tryTimes = 0;

    // 设置APP引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        self.needGuidePage = YES;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 静态引导页
        [self taosetStaticGuidePage];
        
    }else{
        self.needGuidePage = NO;
    }
    
    [self taoRequestConfig];
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
    [UIApplication sharedApplication].delegate.window.rootViewController = self.tabBarController;
}
#pragma mark - getters
- (GlodBulePPXXBJMainViewController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[GlodBulePPXXBJMainViewController alloc] init];
    }
    return _tabBarController;
}

#pragma mark - 设置APP静态图片引导页
- (void)taosetStaticGuidePage {
    NSArray *imageNameArray;
    if ([self taoisIPhoneXSeries]) {
        imageNameArray = @[@"guideImageapp11.jpg",@"guideImageapp12.jpg",@"guideImageapp13.jpg",@"guideImageapp14.jpg", @"guideImageapp15.jpg"];
        
    }else{
        imageNameArray = @[@"guideImageapp1.jpg",@"guideImageapp2.jpg",@"guideImageapp3.jpg",@"guideImageapp4.jpg", @"guideImageapp5.jpg"];
    }
    
    
    GlodBuleDHGuidePageHUD *guidePage = [[GlodBuleDHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    [guidePage setClickListener:^(NSInteger m) {
          [self taoGoIntoMainController];
    }];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];

}

#pragma mark - 设置APP动态图片引导页
- (void)taosetDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    GlodBuleDHGuidePageHUD *guidePage = [[GlodBuleDHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
}

#pragma mark - 设置APP视频引导页
- (void)taosetVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
    GlodBuleDHGuidePageHUD *guidePage = [[GlodBuleDHGuidePageHUD alloc] dh_initWithFrame:self.view.bounds videoURL:videoURL];
    [self.navigationController.view addSubview:guidePage];
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
