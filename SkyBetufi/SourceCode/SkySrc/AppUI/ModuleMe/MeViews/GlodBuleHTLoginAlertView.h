#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, HTLoginPlatform) {
    HTLoginPlatformFB,
    HTLoginPlatformLine,
     HTLoginPlatformAppleId
};
@interface GlodBuleHTLoginAlertView : UIView
+ (void)taoshowLoginAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;
+ (void)taoshowShareAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;

+ (void)taoshowShareAlertViewWithFB:(void(^)(HTLoginPlatform platform))block;
    
@end
NS_ASSUME_NONNULL_END
