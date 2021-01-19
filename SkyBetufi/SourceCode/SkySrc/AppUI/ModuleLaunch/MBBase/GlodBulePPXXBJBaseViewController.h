#import <UIKit/UIKit.h>
#import "GlodBulePPXXBJNavigationController.h"
@interface GlodBulePPXXBJBaseViewController : UIViewController <BJNavigationDelegate>
@property (nonatomic, strong) UIButton *taomeCenterButton;
@property (nonatomic, strong) UIButton *rightSearchButton;
+ (instancetype)taoviewController;
+ (UIImage *)taofixImageSize:(UIImage *)image toSize:(CGSize)toSize;


@end
