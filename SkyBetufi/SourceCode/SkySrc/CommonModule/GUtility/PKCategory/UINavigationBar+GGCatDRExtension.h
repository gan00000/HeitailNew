#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UINavigationBar (GGCatDRExtension)
+ (CGFloat)navigationBarHeight;
- (CGFloat)navigationBarHeight;
+ (BOOL )isIphoneXSeries;
+ (CGFloat)navigationBarTopHeight;
- (void)setupBackground;
@end
NS_ASSUME_NONNULL_END