#import "CCCasePPXXBJBaseViewController.h"
#import "MMTodayHTMeHomeViewController.h"
#import "HoursePPXXBJNavigationController.h"
#import "MMTodayHTUserManager.h"
#import "NDeskHTNewMatchHomeViewController.h"
#import "NDeskHTNewsHomeViewController.h"
#import "RRDogHTFilmHomeViewController.h"
#import "MMTodayHTDataHomeViewController.h"
#import "CCCaseHTRankHomeViewController.h"
#import "GGCatHTTabBarHomeViewController.h"
#import "MMTodaySearchViewController.h"
#import <UIButton+WebCache.h>
#import "CCCaseHTHomeLeftViewController.h"

@import Firebase;

@interface CCCasePPXXBJBaseViewController ()
@end
@implementation CCCasePPXXBJBaseViewController
+ (instancetype)taoviewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"BJBaseViewController viewDidLoad %@",NSStringFromClass([self class]));
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    
    [self.navigationController.navigationBar lt_setBackgroundColor: appBaseColor];
    
    NSLog(@"viewControllers.count = %d", self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count == 1 && ![self isKindOfClass:[MMTodayHTMeHomeViewController class]] && ![self isKindOfClass:[CCCaseHTHomeLeftViewController class]]) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_title"]];
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
    if ([currentClassString isEqualToString:NSStringFromClass([NDeskHTNewMatchHomeViewController class])]) {
        
        [FIRAnalytics logEventWithName:@"IOS_Match"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([NDeskHTNewsHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_News"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([RRDogHTFilmHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Film"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([MMTodayHTDataHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Data"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([CCCaseHTRankHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Rank"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([GGCatHTTabBarHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_MeHome"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([MMTodayHTMeHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_MeHome"
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
        [[PXFunPPXXBJViewControllerCenter mainViewController].drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        return;
    }
    
    MMTodayHTMeHomeViewController *meVc = [MMTodayHTMeHomeViewController taoviewController];
    HoursePPXXBJNavigationController *nav = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:meVc];
    [nav.navigationBar lt_setBackgroundColor:appBaseColor];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showSearchViewController {
    MMTodaySearchViewController *meVc = [MMTodaySearchViewController taoviewController];
//    HoursePPXXBJNavigationController *nav = [[HoursePPXXBJNavigationController alloc] initWithRootViewController:meVc];
//    [nav.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
//    meVc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:meVc animated:YES completion:nil];
     [self.navigationController pushViewController:meVc animated:YES];
}

- (void)taosetupMeCenterButton {//default_avater_view
    
    if ([MMTodayHTUserManager tao_isUserLogin]) {
//        UIImage *userImage = [MMTodayHTUserManager tao_userInfo].avatar;
//        [self.taomeCenterButton setImage:[CCCasePPXXBJBaseViewController taofixImageSize:userImage toSize:CGSizeMake(36, 36)] forState:UIControlStateNormal];
        
        [self.taomeCenterButton sd_setImageWithURL:[NSURL URLWithString:[MMTodayHTUserManager tao_userInfo].user_img] forState:UIControlStateNormal placeholderImage:HT_DEFAULT_AVATAR_LOGO];
    } else {
        
        if (isAppInView) {//top_menu_more
            [self.taomeCenterButton setImage:[UIImage imageNamed:@"top_menu_more"] forState:UIControlStateNormal];
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
    if ([currentClassString isEqualToString:NSStringFromClass([NDeskHTNewsHomeViewController class])]){
        [self.rightSearchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];

    }else if ([currentClassString isEqualToString:NSStringFromClass([RRDogHTFilmHomeViewController class])]){
        
        [self.rightSearchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    }else{
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
