#import <UIKit/UIKit.h>
#import "UIImage+Generator.h"

@interface UIImage (GeneratorMixcode)
+ (void)imageWithColor:(UIColor *)color mixcode:(NSString *)mixcode;
+ (void)imageFromLayer:(CALayer *)layer mixcode:(NSString *)mixcode;

@end
