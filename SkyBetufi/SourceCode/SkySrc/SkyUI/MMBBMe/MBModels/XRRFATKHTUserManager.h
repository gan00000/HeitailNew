#import <Foundation/Foundation.h>
#import "XRRFATKHTUserInfoModel.h"
extern const NSString * kUserLogStatusChagneNotice;
@interface XRRFATKHTUserManager : NSObject
@property (nonatomic, assign)BOOL appInView;
+ (instancetype)manager;
+ (BOOL)skarg_isUserLogin;
+ (XRRFATKHTUserInfoModel *)skarg_userInfo;
+ (NSString *)skarg_userToken;
+ (NSString *)skarg_deviceToken;
+ (void)skarg_saveDeviceToken:(NSString *)deviceToken;
+ (void)skarg_doUserLogin;
+ (void)skarg_doUserLogout;
+ (void)skarg_refreshUserInfoWithSuccessBlock:(dispatch_block_t)block;
+ (void)skargcameraDenied;
+ (void)skargphotoAlbumDenied;
+ (void)skarg_showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              cancelButton:(NSString *)cancelButton
             confirmButton:(NSString *)confirmButton
              confirmBlock:(dispatch_block_t)confirmBlock;
@end
