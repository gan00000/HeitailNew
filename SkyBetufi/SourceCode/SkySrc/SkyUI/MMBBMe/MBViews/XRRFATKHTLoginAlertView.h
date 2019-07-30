#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, HTLoginPlatform) {
    HTLoginPlatformFB,
    HTLoginPlatformLine
};
@interface XRRFATKHTLoginAlertView : UIView
+ (void)skargshowLoginAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;
+ (void)skargshowShareAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;
@end
NS_ASSUME_NONNULL_END
