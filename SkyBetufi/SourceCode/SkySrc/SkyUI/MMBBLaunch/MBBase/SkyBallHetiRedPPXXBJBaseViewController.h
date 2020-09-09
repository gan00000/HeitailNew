#import <UIKit/UIKit.h>
#import "SkyBallHetiRedPPXXBJNavigationController.h"
@interface SkyBallHetiRedPPXXBJBaseViewController : UIViewController <BJNavigationDelegate>
@property (nonatomic, strong) UIButton *waterSkymeCenterButton;
@property (nonatomic, strong) UIButton *rightSearchButton;
+ (instancetype)waterSkyviewController;
+ (UIImage *)waterSkyfixImageSize:(UIImage *)image toSize:(CGSize)toSize;


@end
