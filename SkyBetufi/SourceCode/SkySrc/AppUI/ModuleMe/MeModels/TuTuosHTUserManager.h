#import <Foundation/Foundation.h>
#import "FFlaliHTUserInfoModel.h"
#import "KSasxHTMatchSummaryModel.h"
#import "CfipyPPXXBJMainViewController.h"

extern const NSString * kUserLogStatusChagneNotice;
@interface TuTuosHTUserManager : NSObject
@property (nonatomic, assign)BOOL appInView;
@property (nonatomic, strong) CfipyPPXXBJMainViewController *mainTabBarController;

@property (nonatomic, assign)BOOL showTextLive;

@property (nonatomic, strong) NSMutableDictionary *svgImageCache;

@property (nonatomic, strong) KSasxHTMatchSummaryModel *matchSummaryModel;

+ (instancetype)manager;
+ (BOOL)tao_isUserLogin;
+ (FFlaliHTUserInfoModel *)tao_userInfo;
+ (NSString *)tao_userToken;
+ (NSString *)tao_deviceToken;
+ (void)tao_saveDeviceToken:(NSString *)deviceToken;
+ (void)tao_doUserLogin;
+ (void)tao_doUserLogout;
+ (void)tao_refreshUserInfoWithSuccessBlock:(dispatch_block_t)block;
+ (void)taocameraDenied;
+ (void)taophotoAlbumDenied;
+ (void)tao_showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
              cancelButton:(NSString *)cancelButton
             confirmButton:(NSString *)confirmButton
              confirmBlock:(dispatch_block_t)confirmBlock;

+ (UIColor *)getAppBaseColor;

+(NSString *)getDefaultAvater;

- (void)handleGidSign;

- (void)doThirdLoginRequesWithAccessToken:(NSString *)accessToken sns:(NSInteger)sns userId:(NSString *)userId nickName:(NSString *)nickName email:(NSString *)email;

@end