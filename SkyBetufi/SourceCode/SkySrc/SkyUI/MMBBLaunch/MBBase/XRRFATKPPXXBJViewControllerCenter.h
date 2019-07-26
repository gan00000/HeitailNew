//
//  BJViewControllerCenter.h
//  BenjiaPro
//
//  Created by Marco on 2017/5/26.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRRFATKPPXXBJMainViewController.h"

@interface XRRFATKPPXXBJViewControllerCenter : NSObject

+ (XRRFATKPPXXBJMainViewController *)mainViewController;
+ (UIViewController *)currentViewController;

@end
