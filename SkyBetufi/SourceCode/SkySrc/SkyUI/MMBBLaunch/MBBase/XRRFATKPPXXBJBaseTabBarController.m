//
//  BJTabBarController.m
//  zhugelicai
//
//  Created by Marco on 2017/5/19.
//  Copyright © 2017年 Marco. All rights reserved.
//

#import "XRRFATKPPXXBJBaseTabBarController.h"

@interface XRRFATKPPXXBJBaseTabBarController ()

@end

@implementation XRRFATKPPXXBJBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSArray<UIViewController *> *tabControllers = [self skargtabBarControllers];
    NSArray<UIImage *> *icons = [self skargtabBarIcons];
    NSArray<UIImage *> *selIcons = [self skargtabBarSelectedIcons];
    NSArray<NSString *> *titles = [self skargtabBarTitles];
    
    for (int i = 0; i < tabControllers.count; i++) {
        
        UIImage *tabIcon = nil;
        UIImage *tabSelIcon = nil;
        NSString *title = @"";
        
        if (icons.count > i) {
            tabIcon = icons[i];
        }
        
        if (selIcons.count > i) {
            tabSelIcon = selIcons[i];
        }
        
        if (titles.count > i) {
            title = titles[i];
        }
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:tabIcon selectedImage:tabSelIcon];
        
        UIViewController *controller = tabControllers[i];
        controller.tabBarItem = tabBarItem;
        
    }
    
    self.viewControllers = tabControllers;
    
}

- (BOOL)shouldAutorotate {
    return [[self selectedViewController] shouldAutorotate];
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return [[self selectedViewController] supportedInterfaceOrientations];
//}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return [self selectedViewController].preferredInterfaceOrientationForPresentation;
//}


#pragma mark -
- (NSArray<UIImage *> *)skargtabBarIcons {
    return nil;
}

- (NSArray<UIImage *> *)skargtabBarSelectedIcons {
    return nil;
}

- (NSArray<NSString *> *)skargtabBarTitles {
    return nil;
}

- (NSArray<UIViewController *> *)skargtabBarControllers {
    return nil;
}

@end
