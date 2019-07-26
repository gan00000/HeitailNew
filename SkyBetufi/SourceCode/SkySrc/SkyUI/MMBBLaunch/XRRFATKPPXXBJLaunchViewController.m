//
//  BJLaunchViewController.m
//  BenjiaPro
//
//  Created by Stone.Feng on 2017/12/11.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKPPXXBJLaunchViewController.h"
#import "XRRFATKPPXXBJMainViewController.h"
#import "AppDelegate.h"

@interface XRRFATKPPXXBJLaunchViewController () <CAAnimationDelegate>

@property (nonatomic, strong) XRRFATKPPXXBJMainViewController *tabBarController;

@end

@implementation XRRFATKPPXXBJLaunchViewController

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
    animation.duration = 0.3f;//间隔时间
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.type = kCATransitionFade;
    
    [[UIApplication sharedApplication].delegate.window exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
    [[UIApplication sharedApplication].delegate.window.layer addAnimation:animation forKey:@"animation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
