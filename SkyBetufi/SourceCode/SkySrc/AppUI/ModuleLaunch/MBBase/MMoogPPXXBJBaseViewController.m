#import "MMoogPPXXBJBaseViewController.h"
#import "YeYeeHTMeHomeViewController.h"
#import "UUaksPPXXBJNavigationController.h"
#import "TuTuosHTUserManager.h"
#import "FFlaliHTNewMatchHomeViewController.h"
#import "KSasxHTNewsHomeViewController.h"
#import "CfipyHTFilmHomeViewController.h"
#import "BlysaHTDataHomeViewController.h"
#import "WSKggHTRankHomeViewController.h"
#import "NSNiceHTTabBarHomeViewController.h"
#import "YeYeeSearchViewController.h"
#import <UIButton+WebCache.h>
#import "BlysaHTHomeLeftViewController.h"
#import "BByasPPXXBJLaunchViewController.h"
#import "NSNiceHTMainPageViewController.h"

@import Firebase;

@interface MMoogPPXXBJBaseViewController ()
@end
@implementation MMoogPPXXBJBaseViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"BJBaseViewController viewDidLoad %@",NSStringFromClass([self class]));
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    
    if ([self isKindOfClass:[BByasPPXXBJLaunchViewController class]]) {
        [self.navigationController.navigationBar lt_setBackgroundColor: [UIColor hx_colorWithHexRGBAString:@"54b4ec"]];
    }else{
        [self.navigationController.navigationBar lt_setBackgroundColor: appBaseColor];
    }
   
    
    NSLog(@"viewControllers.count = %d", self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count == 1 && ![self isKindOfClass:[YeYeeHTMeHomeViewController class]] && ![self isKindOfClass:[BlysaHTHomeLeftViewController class]]) {
        
        NSString *nav_icon_title_image = @"gurk_nav_icon_title";
        if (isAppInView) {
            nav_icon_title_image = @"gurk_nav_icon_title_aa";
        }
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:nav_icon_title_image]];
        self.navigationItem.titleView = titleView;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.taomeCenterButton];
        [self taosetupMeCenterButton];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightSearchButton];
        [self setUpRightSearchButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(taosetupMeCenterButton)
                                                     name:kUserLogStatusChagneNotice
                                                   object:nil];
    }
    
    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"EventName_%@",NSStringFromClass([self class])] parameters:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"BJBaseViewController viewWillAppear %@",NSStringFromClass([self class]));
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    NSLog(@"BJBaseViewController viewDidAppear %@",NSStringFromClass([self class]));
    
    NSString *currentClassString = NSStringFromClass([self class]);
    if ([currentClassString isEqualToString:NSStringFromClass([FFlaliHTNewMatchHomeViewController class])]) {
        
        [FIRAnalytics logEventWithName:@"IOS_Match"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([KSasxHTNewsHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_News"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([CfipyHTFilmHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Film"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([BlysaHTDataHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Data"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([WSKggHTRankHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Rank"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([NSNiceHTTabBarHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_MeHome"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([YeYeeHTMeHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_MeHome"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([NSNiceHTMainPageViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Main_Page"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
    }
}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//     NSLog(@"viewWillDisappear");
//}
//
//-(void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//
//     NSLog(@"viewDidDisappear");
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)showMeCenter {
    
    if (isAppInView) {
        [[CfipyPPXXBJViewControllerCenter mainViewController].drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        return;
    }
    
    YeYeeHTMeHomeViewController *meVc = [YeYeeHTMeHomeViewController taoviewController];
    UUaksPPXXBJNavigationController *nav = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:meVc];
    [nav.navigationBar lt_setBackgroundColor:appBaseColor];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showSearchViewController {
    YeYeeSearchViewController *meVc = [YeYeeSearchViewController taoviewController];
//    UUaksPPXXBJNavigationController *nav = [[UUaksPPXXBJNavigationController alloc] initWithRootViewController:meVc];
//    [nav.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
//    meVc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:meVc animated:YES completion:nil];
     [self.navigationController pushViewController:meVc animated:YES];
}

- (void)taosetupMeCenterButton {//default_avater_view
    
    if ([TuTuosHTUserManager tao_isUserLogin]) {
//        UIImage *userImage = [TuTuosHTUserManager tao_userInfo].avatar;
//        [self.taomeCenterButton setImage:[MMoogPPXXBJBaseViewController taofixImageSize:userImage toSize:CGSizeMake(36, 36)] forState:UIControlStateNormal];
        
        [self.taomeCenterButton sd_setImageWithURL:[NSURL URLWithString:[TuTuosHTUserManager tao_userInfo].user_img] forState:UIControlStateNormal placeholderImage:HT_DEFAULT_AVATAR_LOGO];
    } else {
        
        if (isAppInView) {//top_menu_more
            [self.taomeCenterButton setImage:[UIImage imageNamed:@"gurk_top_menu_more"] forState:UIControlStateNormal];
        }else{
            [self.taomeCenterButton setImage:HT_DEFAULT_AVATAR_LOGO forState:UIControlStateNormal];
        }
        
    }
}
- (UIButton *)taomeCenterButton {
    if (!_taomeCenterButton) {
        _taomeCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
        _taomeCenterButton.clipsToBounds = YES;
        _taomeCenterButton.layer.cornerRadius = 18;
        [_taomeCenterButton addTarget:self action:@selector(showMeCenter) forControlEvents:UIControlEventTouchUpInside];
        _taomeCenterButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
       // 测试的时候发现给这个Button设置frame是没有用的，仍然会充满UINavigationBar，我们需要通过下列方式来约束控件的width和height：
        [_taomeCenterButton.widthAnchor constraintEqualToConstant:36].active = YES;
        [_taomeCenterButton.heightAnchor constraintEqualToConstant:36].active = YES;
    }
    return _taomeCenterButton;
}

- (UIButton *)rightSearchButton {
    if (!_rightSearchButton) {
        _rightSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        _rightSearchButton.clipsToBounds = YES;
        _rightSearchButton.layer.cornerRadius = 18;
        [_rightSearchButton addTarget:self action:@selector(showSearchViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightSearchButton;
}

- (void)setUpRightSearchButton {
    
    NSString *currentClassString = NSStringFromClass([self class]);
    if ([currentClassString isEqualToString:NSStringFromClass([KSasxHTNewsHomeViewController class])]){
        [self.rightSearchButton setImage:[UIImage imageNamed:@"gurk_icon_search"] forState:UIControlStateNormal];

    }else if ([currentClassString isEqualToString:NSStringFromClass([CfipyHTFilmHomeViewController class])]){
        
        [self.rightSearchButton setImage:[UIImage imageNamed:@"gurk_icon_search"] forState:UIControlStateNormal];
    }else if (isAppInView && [currentClassString isEqualToString:NSStringFromClass([NSNiceHTMainPageViewController class])]){
        
        [self.rightSearchButton setImage:[UIImage imageNamed:@"gurk_icon_search"] forState:UIControlStateNormal];
    }
    
    else{
        self.rightSearchButton.hidden = YES;
    }
    
}

+ (UIImage *)taofixImageSize:(UIImage *)image toSize:(CGSize)toSize {
    CGSize size = image.size;
    if (size.width == size.height) {
        return [self tao_imageWithOriginalImage:image withScaleSize:toSize];
    } else {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        CGFloat inset = (size.height - size.width) / 2;
        CGRect newRect = CGRectInset(rect, inset < 0? fabs(inset) : 0, inset > 0? inset : 0);
        UIImage *subImage = [self tao_imagecutWithOriginalImage:image withCutRect:newRect];
        return [self tao_imageWithOriginalImage:subImage withScaleSize:toSize];
    }
}
+ (UIImage *)tao_imagecutWithOriginalImage:(UIImage *)originalImage withCutRect:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(originalImage.CGImage, rect);
    CGRect smallRect = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContextWithOptions(smallRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallRect, subImageRef);
    UIImage * image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return image;
}
+ (UIImage *)tao_imageWithOriginalImage:(UIImage *)originalImage withScaleSize:(CGSize)size {
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
