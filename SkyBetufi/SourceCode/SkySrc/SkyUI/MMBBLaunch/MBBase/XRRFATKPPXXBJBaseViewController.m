//
//  BJBaseViewController.m
//  BenjiaPro
//
//  Created by Marco on 2017/5/23.
//  Copyright © 2017年 Benjia. All rights reserved.
//

#import "XRRFATKPPXXBJBaseViewController.h"
#import "XRRFATKHTMeHomeViewController.h"
#import "XRRFATKPPXXBJNavigationController.h"

@interface XRRFATKPPXXBJBaseViewController ()

@property (nonatomic, strong) UIButton *skargmeCenterButton;

@end

@implementation XRRFATKPPXXBJBaseViewController

+ (instancetype)skargviewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    if (self.navigationController.viewControllers.count == 1 && ![self isKindOfClass:[XRRFATKHTMeHomeViewController class]]) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_title"]];
        self.navigationItem.titleView = titleView;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.skargmeCenterButton];
        [self skargsetupMeCenterButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(skargsetupMeCenterButton)
                                                     name:kUserLogStatusChagneNotice
                                                   object:nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showMeCenter {
    XRRFATKHTMeHomeViewController *meVc = [XRRFATKHTMeHomeViewController skargviewController];
    XRRFATKPPXXBJNavigationController *nav = [[XRRFATKPPXXBJNavigationController alloc] initWithRootViewController:meVc];
    [nav.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)skargsetupMeCenterButton {
    if ([XRRFATKHTUserManager skarg_isUserLogin]) {
        [self.skargmeCenterButton setImage:[XRRFATKPPXXBJBaseViewController skargfixImageSize:[XRRFATKHTUserManager skarg_userInfo].avatar toSize:CGSizeMake(36, 36)] forState:UIControlStateNormal];
    } else {
        [self.skargmeCenterButton setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    }
}

- (UIButton *)skargmeCenterButton {
    if (!_skargmeCenterButton) {
        _skargmeCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
        _skargmeCenterButton.clipsToBounds = YES;
        _skargmeCenterButton.layer.cornerRadius = 18;
        [_skargmeCenterButton addTarget:self action:@selector(showMeCenter) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skargmeCenterButton;
}

+ (UIImage *)skargfixImageSize:(UIImage *)image toSize:(CGSize)toSize {
    CGSize size = image.size;
    if (size.width == size.height) {
        return [self skarg_imageWithOriginalImage:image withScaleSize:toSize];
    } else {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        CGFloat inset = (size.height - size.width) / 2;
        CGRect newRect = CGRectInset(rect, inset < 0? fabs(inset) : 0, inset > 0? inset : 0);
        UIImage *subImage = [self skarg_imagecutWithOriginalImage:image withCutRect:newRect];
        return [self skarg_imageWithOriginalImage:subImage withScaleSize:toSize];
    }
}


+ (UIImage *)skarg_imagecutWithOriginalImage:(UIImage *)originalImage withCutRect:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(originalImage.CGImage, rect);
    CGRect smallRect = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    // 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(smallRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallRect, subImageRef);
    UIImage * image = [UIImage imageWithCGImage:subImageRef];
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);
    return image;
}

+ (UIImage *)skarg_imageWithOriginalImage:(UIImage *)originalImage withScaleSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [originalImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
