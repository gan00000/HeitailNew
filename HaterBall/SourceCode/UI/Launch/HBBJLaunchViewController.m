#import "HBBJLaunchViewController.h"
#import "HBBJMainViewController.h"
#import "HBAppDelegate.h"
@interface HBBJLaunchViewController () <CAAnimationDelegate>
@property (nonatomic, strong) HBBJMainViewController *tabBarController;
@end
@implementation HBBJLaunchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *imageName = [NSString stringWithFormat:@"%ldx%ld", (long)(SCREEN_WIDTH*SCREEN_SCALE), (long)(SCREEN_HEIGHT*SCREEN_SCALE)];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *launchImageView = [[UIImageView alloc] init];
    launchImageView.image = image;
    [self.view addSubview:launchImageView];
    [launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    [[UIApplication sharedApplication].delegate.window insertSubview:self.tabBarController.view atIndex:0];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionFade;
    [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [UIApplication sharedApplication].delegate.window.rootViewController = self.tabBarController;
}
#pragma mark - getters
- (HBBJMainViewController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[HBBJMainViewController alloc] init];
    }
    return _tabBarController;
}
@end
