#import "UIImage+GeneratorMixcode.h"
@implementation UIImage (GeneratorMixcode)
+ (void)imageWithColor:(UIColor *)color mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}
+ (void)imageFromLayer:(CALayer *)layer mixcode:(NSString *)mixcode {
    NSLog(@"%@", mixcode);
}

@end
