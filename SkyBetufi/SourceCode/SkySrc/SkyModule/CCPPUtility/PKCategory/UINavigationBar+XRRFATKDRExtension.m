//
//  UINavigationBar+XRRFATKDRExtension.m
//  DRBasicKit
//
//  Created by 冯生伟 on 2019/3/15.
//

#import "UINavigationBar+XRRFATKDRExtension.h"

@implementation UINavigationBar (XRRFATKDRExtension)

+ (CGFloat)navigationBarHeight {
    CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    return statusBarHeight + 44.0;
}

+ (CGFloat)navigationBarTopHeight {
    if ([self isIphoneXSeries]) {
        return 22.0;
    }
    return 0.0;
}

- (CGFloat)navigationBarHeight {
    CGFloat statusBarHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    return statusBarHeight + self.frame.size.height;
}

+ (BOOL )isIphoneXSeries {
    if (@available(iOS 11.0, *)) {
        return  [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;
    }else{
        return NO;
    }
}

- (void)setupBackground {
    CALayer *layer = [CALayer layer];
    layer.frame = self.bounds;
    layer.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"fc562e"].CGColor;
    
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

@end
