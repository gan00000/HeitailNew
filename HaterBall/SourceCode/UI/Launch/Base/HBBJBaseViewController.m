#import "HBBJBaseViewController.h"
#import <LTNavigationBar/UINavigationBar+Awesome.h>
#import "HBSettingViewController.h"
@interface HBBJBaseViewController ()
@end
@implementation HBBJBaseViewController
+ (instancetype)viewController {
    return kLoadStoryboardWithName(NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA_COLOR_HEX(0xf4f4f4);
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"fc562e"]];
    if (self.navigationController.viewControllers.count == 1) {
        UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon_title"]];
        self.navigationItem.titleView = titleView;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(showSettingVc)];
    }
}
- (void)showSettingVc {
    HBSettingViewController *setvc = [HBSettingViewController viewController];
    [self.navigationController pushViewController:setvc animated:YES];
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
