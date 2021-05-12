#import "UINavigationBar+GGCatGlodBuleDDYExtension.h"
#import <objc/runtime.h>

@implementation UINavigationBar (DDYExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"UINavigationBar+GGCatGlodBuleDDYExtension %@", NSStringFromClass([self class]));
        [self changeOrignalSEL:@selector(sizeThatFits:) swizzleSEL:@selector(ddy_SizeThatFits:)];
        [self changeOrignalSEL:@selector(layoutSubviews) swizzleSEL:@selector(ddy_LayoutSubviews)];
    });
}

+ (void)changeOrignalSEL:(SEL)orignalSEL swizzleSEL:(SEL)swizzleSEL {
    Method originalMethod = class_getInstanceMethod([self class], orignalSEL);
    Method swizzleMethod = class_getInstanceMethod([self class], swizzleSEL);
    if (class_addMethod([self class], orignalSEL, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod))) {
        class_replaceMethod([self class], swizzleSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}


- (CGSize)ddy_SizeThatFits:(CGSize)size {
    CGSize navigationBarSize = [self ddy_SizeThatFits:size];
    if (@available(iOS 11, *)) {
        navigationBarSize.height = navigationBarSize.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    return navigationBarSize;
}

- (void)ddy_LayoutSubviews {
    
    [self ddy_LayoutSubviews];
    if (@available(iOS 11, *)) {
        for (UIView *subView in self.subviews) {
            if ([NSStringFromClass([subView class]) isEqualToString: @"_UIBarBackground"]) {
                CGRect rc = subView.frame;
                rc.size.height = 44 + [[UIApplication sharedApplication] statusBarFrame].size.height;
                rc.origin.y = 0;
                subView.frame = rc;
            }else if ([NSStringFromClass([subView class]) isEqualToString: @"_UINavigationBarContentView"]){
                CGRect rc = subView.frame;
                rc.size.height = 44;
                rc.origin.y = [[UIApplication sharedApplication] statusBarFrame].size.height;
                subView.frame = rc;
            }
        }
    }
}

@end
