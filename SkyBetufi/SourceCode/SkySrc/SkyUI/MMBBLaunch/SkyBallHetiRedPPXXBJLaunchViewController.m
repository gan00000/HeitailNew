#import "SkyBallHetiRedPPXXBJLaunchViewController.h"
#import "SkyBallHetiRedPPXXBJMainViewController.h"
#import "AppDelegate.h"
#import "SkyBallHetiRedBJHTTPServiceEngine.h"

#import "SkyBallHetiRedDHGuidePageHUD.h"

@interface SkyBallHetiRedPPXXBJLaunchViewController () <CAAnimationDelegate>
@property (nonatomic, strong) SkyBallHetiRedPPXXBJMainViewController *tabBarController;
@property (nonatomic, assign) NSInteger tryTimes;
@property (nonatomic, assign) BOOL needGuidePage;
@end
@implementation SkyBallHetiRedPPXXBJLaunchViewController
- (void)waterSkyGoIntoMainController {
    [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.1f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionFade;
    [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
}

- (void)waterSkyRequestConfig {
    [SkyBallHetiRedBJHTTPServiceEngine waterSky_getRequestCommon:@"ios_config.json" params:nil successBlock:^(id responseData) {
        NSDictionary *configDictionary = responseData; 
        if (configDictionary) {
            NSString *version = configDictionary[@"version"];
            NSString *status = configDictionary[@"status"];
            NSString *examine = configDictionary[@"examine"];
            NSString *showTextLive = configDictionary[@"showTextLive"];
            
            if ([examine isEqualToString:@"1"]) {
                [SkyBallHetiRedHTUserManager manager].appInView = YES;
                BJLog(@"getRequestCommon in view");
            }else{
                BJLog(@"getRequestCommon not in view");
                [SkyBallHetiRedHTUserManager manager].appInView = NO;
            }
            
            if ([showTextLive isEqualToString:@"1"]) {//是否显示文字直播
                [SkyBallHetiRedHTUserManager manager].showTextLive = YES;
              
            }else{
                
                [SkyBallHetiRedHTUserManager manager].showTextLive = NO;//showTextLive 0 是不显示
            }
        }
        
        if (!self.needGuidePage) {
            [self waterSkyGoIntoMainController];
        }
        
    } errorBlock:^(SkyBallHetiRedBJError *error) {
        BJLog(@"ERROR:%@",error);
        if (self.tryTimes == 0) {
            self.tryTimes++;
            [self waterSkyRequestConfig];
            return;
        }
        [SkyBallHetiRedHTUserManager manager].appInView = NO;
        
        if (!self.needGuidePage) {
            [self waterSkyGoIntoMainController];
        }
        
    }];
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
        [self waterSkysetStaticGuidePage];
        
    }else{
        self.needGuidePage = NO;
    }
    
    [self waterSkyRequestConfig];
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
- (SkyBallHetiRedPPXXBJMainViewController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[SkyBallHetiRedPPXXBJMainViewController alloc] init];
    }
    return _tabBarController;
}

#pragma mark - 设置APP静态图片引导页
- (void)waterSkysetStaticGuidePage {
    NSArray *imageNameArray;
    if ([self waterSkyisIPhoneXSeries]) {
        imageNameArray = @[@"guideImageapp11.jpg",@"guideImageapp12.jpg",@"guideImageapp13.jpg",@"guideImageapp14.jpg", @"guideImageapp15.jpg"];
        
    }else{
        imageNameArray = @[@"guideImageapp1.jpg",@"guideImageapp2.jpg",@"guideImageapp3.jpg",@"guideImageapp4.jpg", @"guideImageapp5.jpg"];
    }
    
    
    SkyBallHetiRedDHGuidePageHUD *guidePage = [[SkyBallHetiRedDHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    [guidePage setClickListener:^(NSInteger m) {
          [self waterSkyGoIntoMainController];
    }];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];

}

#pragma mark - 设置APP动态图片引导页
- (void)waterSkysetDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    SkyBallHetiRedDHGuidePageHUD *guidePage = [[SkyBallHetiRedDHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
}

#pragma mark - 设置APP视频引导页
- (void)waterSkysetVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
    SkyBallHetiRedDHGuidePageHUD *guidePage = [[SkyBallHetiRedDHGuidePageHUD alloc] dh_initWithFrame:self.view.bounds videoURL:videoURL];
    [self.navigationController.view addSubview:guidePage];
}

-(BOOL)waterSkyisIPhoneXSeries
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
