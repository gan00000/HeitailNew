#import <UIKit/UIKit.h>
#import "GlodBulePPXXBJNavigationController.h"
@interface GlodBulePPXXBJBaseViewController : UIViewController <BJNavigationDelegate>
@property (nonatomic, strong) UIButton *waterSkymeCenterButton;
@property (nonatomic, strong) UIButton *rightSearchButton;
+ (instancetype)waterSkyviewController;
+ (UIImage *)waterSkyfixImageSize:(UIImage *)image toSize:(CGSize)toSize;


@end
