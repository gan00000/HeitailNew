#import <UIKit/UIKit.h>
#import "SkyBallHetiRedPPXXBJNavigationController.h"
@interface SkyBallHetiRedPPXXBJBaseViewController : UIViewController <BJNavigationDelegate>
@property (nonatomic, strong) UIButton *waterSkymeCenterButton;
+ (instancetype)waterSkyviewController;
+ (UIImage *)waterSkyfixImageSize:(UIImage *)image toSize:(CGSize)toSize;
@end
