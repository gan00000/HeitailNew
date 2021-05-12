//
//  NDeskHTImageBrowserViewController.m
//  SkyBallPlay
//
//  Created by ganyuanrong on 2019/12/17.
//  Copyright © 2019 Dean_F. All rights reserved.
//

#import "NDeskHTImageBrowserViewController.h"
#import "SundayWBImageBrowserView.h"

@interface NDeskHTImageBrowserViewController ()<WBImageBrowserViewDelegate>
{
    SundayWBImageBrowserView *pictureBrowserView;
    NSArray  *listAM;
}

@end

@implementation NDeskHTImageBrowserViewController

- (instancetype)initWithImages:(NSArray *) mImages
{
    self = [super init];
    if (self) {
        listAM = mImages;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    listAM = [NSMutableArray arrayWithArray:@[
//                                               @{@"url":@"http://img4.duitang.com/uploads/item/201406/20/20140620193408_hcjVU.thumb.700_0.jpeg",
//                                                 @"title":@"图片1111"},
//                                               @{ @"url":@"http://k.zol-img.com.cn/nbbbs/8502/a8501016_s.jpg",
//                                                  @"title":@"图片222" },
//                                               @{ @"url":@"http://img4q.duitang.com/uploads/item/201502/11/20150211095924_nLKCs.jpeg",
//                                                  @"title":@"图片333" },
//                                               @{ @"url":@"http://admin.anzow.com/picture/2011103144134311.jpg",
//                                                  @"title":@"图片444444" },
//                                               @{ @"url":@"http://img5.duitang.com/uploads/item/201507/25/20150725104636_vKir4.jpeg",
//                                                  @"title":@"图片5555" },
//                                               @{ @"url":@"http://img5.duitang.com/uploads/item/201508/08/20150808112252_MUhiH.jpeg",
//                                                  @"title":@"图片6666" },
//                                               @{ @"url":@"http://img5.duitang.com/uploads/item/201507/25/20150725104636_vKir4.jpeg",
//                                                  @"title":@"图片77777" },
//                                               @{ @"url":@"http://img4.duitang.com/uploads/item/201406/27/20140627140613_H8NHy.jpeg",
//                                                  @"title":@"图片88888" }
//                                               ]];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(111, 111, 111, 55);
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    
    
       [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

       [SundayWBImageBrowserView clearImagesCache];
       
       pictureBrowserView = [SundayWBImageBrowserView pictureBrowsweViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                     delegate:self
                                                             browserInfoArray:listAM];

       pictureBrowserView.orientation = self.interfaceOrientation;
       pictureBrowserView.viewController = self;
       pictureBrowserView.startIndex = 1;  //开始索引
       [pictureBrowserView showInView:[UIApplication sharedApplication].delegate.window];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    // 控制器只支持竖屏, 浏览图片时支持横屏
    // 根据状态栏判断
    if ([UIApplication sharedApplication].isStatusBarHidden) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)pictureBrowserViewhide {
    
    // 检查屏幕横竖屏 强制竖屏
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        NSNumber *num = [[NSNumber alloc] initWithInt:UIInterfaceOrientationPortrait];
//        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)num];
//        [UIViewController attemptRotationToDeviceOrientation];
//    }
//    SEL selector = NSSelectorFromString(@"setOrientation:");
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//    [invocation setSelector:selector];
//    [invocation setTarget:[UIDevice currentDevice]];
//    int val = UIInterfaceOrientationPortrait ;
//    [invocation setArgument:&val atIndex:2];
//    [invocation invoke];
}

- (void)clickBackBtn{
    
    if (self.navigationController.childViewControllers.count < 2) {
         [self.navigationController dismissViewControllerAnimated:NO completion:nil];
         return;
     }
     [self.navigationController popViewControllerAnimated:NO];
    
    
}
    


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat newVcH;
    CGFloat newVcW;
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        // 横屏
        newVcH = [UIScreen mainScreen].bounds.size.width;
        newVcW = [UIScreen mainScreen].bounds.size.height;
    } else {
        // 竖屏
        newVcW = [UIScreen mainScreen].bounds.size.width ;
        newVcH = [UIScreen mainScreen].bounds.size.height;
    }
    
    self.view.frame = CGRectMake(0, 0, newVcW, newVcH);
    pictureBrowserView.orientation = self.interfaceOrientation;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
