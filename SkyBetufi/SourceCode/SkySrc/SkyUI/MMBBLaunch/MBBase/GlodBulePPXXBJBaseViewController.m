#import "GlodBulePPXXBJBaseViewController.h"
#import "GlodBuleHTMeHomeViewController.h"
#import "GlodBulePPXXBJNavigationController.h"
#import "GlodBuleHTUserManager.h"
#import "GlodBuleHTMatchHomeViewController.h"
#import "GlodBuleHTNewsHomeViewController.h"
#import "GlodBuleHTFilmHomeViewController.h"
#import "GlodBuleHTDataHomeViewController.h"
#import "GlodBuleHTRankHomeViewController.h"
#import "GlodBuleHTTabBarHomeViewController.h"
#import "GlodBuleSearchViewController.h"
@import Firebase;

@interface GlodBulePPXXBJBaseViewController ()
@end
@implementation GlodBulePPXXBJBaseViewController
+ (instancetype)waterSkyviewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"BJBaseViewController viewDidLoad %@",NSStringFromClass([self class]));
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    
    if ([GlodBuleHTUserManager manager].appInView) {
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"286ffb"]];
    }else{
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
        
    }
    NSLog(@"viewControllers.count = %d", self.navigationController.viewControllers.count);
    if (self.navigationController.viewControllers.count == 1 && ![self isKindOfClass:[GlodBuleHTMeHomeViewController class]]) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_title"]];
        self.navigationItem.titleView = titleView;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.waterSkymeCenterButton];
        [self waterSkysetupMeCenterButton];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightSearchButton];
        [self setUpRightSearchButton];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(waterSkysetupMeCenterButton)
                                                     name:kUserLogStatusChagneNotice
                                                   object:nil];
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"BJBaseViewController viewWillAppear %@",NSStringFromClass([self class]));
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    NSLog(@"BJBaseViewController viewDidAppear %@",NSStringFromClass([self class]));
    
    NSString *currentClassString = NSStringFromClass([self class]);
    if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTMatchHomeViewController class])]) {
        
        [FIRAnalytics logEventWithName:@"IOS_Match"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTNewsHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_News"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTFilmHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Film"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTDataHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Data"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTRankHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_Rank"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTTabBarHomeViewController class])]){
        
        [FIRAnalytics logEventWithName:@"IOS_MeHome"
                            parameters:@{
                                         kFIRParameterItemID:[NSString stringWithFormat:@"id-%@", self.title],
                                         kFIRParameterItemName:self.title,
                                         kFIRParameterContentType:@"button"
                                         }];
        
    }else if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTMeHomeViewController class])]){
        
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
    GlodBuleHTMeHomeViewController *meVc = [GlodBuleHTMeHomeViewController waterSkyviewController];
    GlodBulePPXXBJNavigationController *nav = [[GlodBulePPXXBJNavigationController alloc] initWithRootViewController:meVc];
    [nav.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showSearchViewController {
    GlodBuleSearchViewController *meVc = [GlodBuleSearchViewController waterSkyviewController];
//    GlodBulePPXXBJNavigationController *nav = [[GlodBulePPXXBJNavigationController alloc] initWithRootViewController:meVc];
//    [nav.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
//    meVc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:meVc animated:YES completion:nil];
     [self.navigationController pushViewController:meVc animated:YES];
}

- (void)waterSkysetupMeCenterButton {
    if ([GlodBuleHTUserManager waterSky_isUserLogin]) {
        [self.waterSkymeCenterButton setImage:[GlodBulePPXXBJBaseViewController waterSkyfixImageSize:[GlodBuleHTUserManager waterSky_userInfo].avatar toSize:CGSizeMake(36, 36)] forState:UIControlStateNormal];
    } else {
        [self.waterSkymeCenterButton setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
    }
}
- (UIButton *)waterSkymeCenterButton {
    if (!_waterSkymeCenterButton) {
        _waterSkymeCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
        _waterSkymeCenterButton.clipsToBounds = YES;
        _waterSkymeCenterButton.layer.cornerRadius = 18;
        [_waterSkymeCenterButton addTarget:self action:@selector(showMeCenter) forControlEvents:UIControlEventTouchUpInside];
    }
    return _waterSkymeCenterButton;
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
    if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTNewsHomeViewController class])]){
        [self.rightSearchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];

    }else if ([currentClassString isEqualToString:NSStringFromClass([GlodBuleHTFilmHomeViewController class])]){
        
        [self.rightSearchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    }else{
        self.rightSearchButton.hidden = YES;
    }
    
}

+ (UIImage *)waterSkyfixImageSize:(UIImage *)image toSize:(CGSize)toSize {
    CGSize size = image.size;
    if (size.width == size.height) {
        return [self waterSky_imageWithOriginalImage:image withScaleSize:toSize];
    } else {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        CGFloat inset = (size.height - size.width) / 2;
        CGRect newRect = CGRectInset(rect, inset < 0? fabs(inset) : 0, inset > 0? inset : 0);
        UIImage *subImage = [self waterSky_imagecutWithOriginalImage:image withCutRect:newRect];
        return [self waterSky_imageWithOriginalImage:subImage withScaleSize:toSize];
    }
}
+ (UIImage *)waterSky_imagecutWithOriginalImage:(UIImage *)originalImage withCutRect:(CGRect)rect {
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
+ (UIImage *)waterSky_imageWithOriginalImage:(UIImage *)originalImage withScaleSize:(CGSize)size {
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
