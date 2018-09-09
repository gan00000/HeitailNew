//
//  BJBaseViewController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/23.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "BJBaseViewController.h"
#import <LTNavigationBar/UINavigationBar+Awesome.h>

@interface BJBaseViewController ()

@end

@implementation BJBaseViewController

+ (instancetype)viewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor redColor]];
    if (self.navigationController.viewControllers.count == 1) {
        self.title = self.navigationController.tabBarItem.title;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
