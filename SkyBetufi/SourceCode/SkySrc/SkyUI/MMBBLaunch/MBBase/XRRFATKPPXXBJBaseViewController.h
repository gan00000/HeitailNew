#import <UIKit/UIKit.h>
#import "XRRFATKPPXXBJNavigationController.h"
@interface XRRFATKPPXXBJBaseViewController : UIViewController <BJNavigationDelegate>
@property (nonatomic, strong) UIButton *skargmeCenterButton;
+ (instancetype)skargviewController;
+ (UIImage *)skargfixImageSize:(UIImage *)image toSize:(CGSize)toSize;
@end
