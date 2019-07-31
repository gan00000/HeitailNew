#import "XRRFATKPPXXBJLaunchViewController.h"
#import "XRRFATKPPXXBJMainViewController.h"
#import "AppDelegate.h"
#import "XRRFATKBJHTTPServiceEngine.h"

#import "DHGuidePageHUD.h"

@interface XRRFATKPPXXBJLaunchViewController () <CAAnimationDelegate>
@property (nonatomic, strong) XRRFATKPPXXBJMainViewController *tabBarController;
@property (nonatomic, assign) NSInteger tryTimes;
@property (nonatomic, assign) BOOL needGuidePage;
@end
@implementation XRRFATKPPXXBJLaunchViewController
- (void)skargGoIntoMainController {
    [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.1f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionFade;
    [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
}

- (void)skargRequestConfig {
    [XRRFATKBJHTTPServiceEngine skarg_getRequestCommon:@"ios_config.json" params:nil successBlock:^(id responseData) {
        NSDictionary *configDictionary = responseData; 
        if (configDictionary) {
            NSString *version = configDictionary[@"version"];
            NSString *status = configDictionary[@"status"];
            NSString *examine = configDictionary[@"examine"];
            if ([examine isEqualToString:@"1"]) {
                [XRRFATKHTUserManager manager].appInView = YES;
                BJLog(@"getRequestCommon in view");
            }else{
                BJLog(@"getRequestCommon not in view");
                [XRRFATKHTUserManager manager].appInView = NO;
            }
        }
        
        if (!self.needGuidePage) {
            [self skargGoIntoMainController];
        }
        
    } errorBlock:^(XRRFATKBJError *error) {
        BJLog(@"ERROR:%@",error);
        if (self.tryTimes == 0) {
            self.tryTimes++;
            [self skargRequestConfig];
            return;
        }
        [XRRFATKHTUserManager manager].appInView = NO;
        
        if (!self.needGuidePage) {
            [self skargGoIntoMainController];
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
        [self skargsetStaticGuidePage];
        
    }else{
        self.needGuidePage = NO;
    }
    
    [self skargRequestConfig];
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
- (XRRFATKPPXXBJMainViewController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[XRRFATKPPXXBJMainViewController alloc] init];
    }
    return _tabBarController;
}

#pragma mark - 设置APP静态图片引导页
- (void)skargsetStaticGuidePage {
    NSArray *imageNameArray = @[@"guideImageapp1.jpg",@"guideImageapp2.jpg",@"guideImageapp3.jpg", @"guideImageapp5.jpg"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    [guidePage setClickListener:^(NSInteger m) {
          [self skargGoIntoMainController];
    }];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];

}

#pragma mark - 设置APP动态图片引导页
- (void)skargsetDynamicGuidePage {
    NSArray *imageNameArray = @[@"guideImage6.gif",@"guideImage7.gif",@"guideImage8.gif"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    [self.navigationController.view addSubview:guidePage];
}

#pragma mark - 设置APP视频引导页
- (void)skargsetVideoGuidePage {
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"guideMovie1" ofType:@"mov"]];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.bounds videoURL:videoURL];
    [self.navigationController.view addSubview:guidePage];
}

@end
