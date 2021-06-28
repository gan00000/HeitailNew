#import <UIKit/UIKit.h>
@import Firebase;
@import GoogleSignIn;

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, HTLoginPlatform) {
    HTLoginPlatformFB,
    HTLoginPlatformLine,
    HTLoginPlatformSave,
    HTLoginPlatformAppleId,
    HTLoginPlatformGid
};
@interface MMoogHTLoginAlertView : UIView
+ (void)taoshowLoginAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;
+ (void)taoshowShareAlertViewWithSelectBlock:(void(^)(HTLoginPlatform platform))block;

+ (void)taoshowShareAlertViewWithFB:(void(^)(HTLoginPlatform platform))block;

+ (void)taoshowShareAlertViewWithFBAndSave:(void(^)(HTLoginPlatform platform))block;
    
@end
NS_ASSUME_NONNULL_END
