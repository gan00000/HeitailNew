//
//  BJBaseViewController.h
//  BenjiaPro
//
//  Created by Marco on 2017/5/23.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRRFATKPPXXBJNavigationController.h"

@interface XRRFATKPPXXBJBaseViewController : UIViewController <BJNavigationDelegate>

/// 子类必须重写
+ (instancetype)viewController;

+ (UIImage *)fixImageSize:(UIImage *)image toSize:(CGSize)toSize;

@end
