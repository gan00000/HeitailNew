#import <UIKit/UIKit.h>
#import "YeYeePPXXBJNavigationController.h"
#import "MMDrawerController.h"

@interface WSKggPPXXBJBaseViewController : UIViewController <BJNavigationDelegate>
@property (nonatomic, strong) UIButton *taomeCenterButton;
@property (nonatomic, strong) UIButton *rightSearchButton;
+ (instancetype)taoviewController;
+ (UIImage *)taofixImageSize:(UIImage *)image toSize:(CGSize)toSize;

@property (nonatomic,strong) MMDrawerController * drawerController;


@end
