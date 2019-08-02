#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, HTLoginPlatform) {
    HTLoginPlatformFB,
    HTLoginPlatformLine
};
@interface SkyBallHetiRedHTLoginAlertView : UIView
+ (void)waterSkyshowLoginAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;
+ (void)waterSkyshowShareAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;
@end
NS_ASSUME_NONNULL_END
