#import <UIKit/UIKit.h>
#import "UUaksPPXXBJNavigationController.h"
#import "MMDrawerController.h"

@interface MMoogPPXXBJBaseViewController : UIViewController <BJNavigationDelegate>
@property (nonatomic, strong) UIButton *taomeCenterButton;
@property (nonatomic, strong) UIButton *rightSearchButton;
+ (instancetype)taoviewController;
+ (UIImage *)taofixImageSize:(UIImage *)image toSize:(CGSize)toSize;

@property (nonatomic,strong) MMDrawerController * drawerController;


@end
