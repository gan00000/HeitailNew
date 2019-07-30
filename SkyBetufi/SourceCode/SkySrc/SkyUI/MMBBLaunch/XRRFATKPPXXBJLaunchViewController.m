#import "XRRFATKPPXXBJLaunchViewController.h"
#import "XRRFATKPPXXBJMainViewController.h"
#import "AppDelegate.h"
#import "XRRFATKBJHTTPServiceEngine.h"
@interface XRRFATKPPXXBJLaunchViewController () <CAAnimationDelegate>
@property (nonatomic, strong) XRRFATKPPXXBJMainViewController *tabBarController;
@property (nonatomic, assign) NSInteger tryTimes;
@end
@implementation XRRFATKPPXXBJLaunchViewController
- (void)requestConfig {
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
        [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
        animation.type = kCATransitionFade;
        [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
    } errorBlock:^(XRRFATKBJError *error) {
        BJLog(@"ERROR:%@",error);
        if (self.tryTimes == 0) {
            self.tryTimes++;
            [self requestConfig];
            return;
        }
        [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.2f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
        animation.type = kCATransitionFade;
        [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    BJLog(@"getRequestCommon start");
    self.tryTimes = 0;
    [self requestConfig];
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
@end
